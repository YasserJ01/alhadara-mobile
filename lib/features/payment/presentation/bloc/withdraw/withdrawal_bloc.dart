// presentation/pages/withdraw/bloc/withdrawal_bloc.dart
import '../../../domain/entities/withdrawal_entity.dart';
import '../../../domain/usecases/create_withdrawal_request.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import '../../../../../errors/failures.dart';

part 'withdrawal_event.dart';
part 'withdrawal_state.dart';

class WithdrawalBloc extends Bloc<WithdrawalEvent, WithdrawalState> {
  final CreateWithdrawalRequest createWithdrawalRequest;

  WithdrawalBloc({required this.createWithdrawalRequest})
      : super(const WithdrawalState()) {
    on<WithdrawalAmountChanged>(_onAmountChanged);
    on<WithdrawalSubmitted>(_onSubmitted);
  }

  void _onAmountChanged(
    WithdrawalAmountChanged event,
    Emitter<WithdrawalState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
  }

  Future<void> _onSubmitted(
    WithdrawalSubmitted event,
    Emitter<WithdrawalState> emit,
  ) async {
    if (state.amount.isEmpty) {
      return;
    }

    emit(state.copyWith(formStatus: const FormSubmitting()));

    try {
      // Generate pickup datetime (current time + 24 hours)
      final now = DateTime.now();
      final pickupDatetime = now.add(const Duration(hours: 24));
      final formattedPickupDatetime =
          DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(pickupDatetime);

      final amount = double.parse(state.amount);

      final withdrawal = await createWithdrawalRequest(
        amount: amount,
        pickupDatetime: formattedPickupDatetime,
      );

      // ✅ بعد نجاح العملية
      emit(
        state.copyWith(
          formStatus: SubmissionSuccess(withdrawal),
        ),
      );
    } on FormatException {
      emit(
        state.copyWith(
          formStatus: SubmissionFailed(
            ValidationFailure(),
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          formStatus: SubmissionFailed(ServerFailure()),
        ),
      );
    }
  }

  // ✅ إعادة تعيين الحالة كاملة للوضع الابتدائي
  void resetState() {
    emit(const WithdrawalState());
  }
}
