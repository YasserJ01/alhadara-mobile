// presentation/bloc/deposit_request_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../errors/failures.dart';
import '../../../domain/usecases/create_deposit_request.dart';
import 'deposit_request_event.dart';
import 'deposit_request_state.dart';

class DepositRequestBloc extends Bloc<DepositRequestEvent, DepositRequestState> {
  final CreateDepositRequest createDepositRequest;

  DepositRequestBloc({
    required this.createDepositRequest,
  }) : super(DepositRequestInitial()) {
    on<CreateDepositRequestEvent>(_onCreateDepositRequest);
  }

  Future<void> _onCreateDepositRequest(
      CreateDepositRequestEvent event,
      Emitter<DepositRequestState> emit,
      ) async {
    emit(DepositRequestLoading());

    try {
      final depositRequest = await createDepositRequest(
        screenshotFile: event.screenshotFile,
        depositMethodId: event.depositMethodId,
        transactionNumber: event.transactionNumber,
        amount: event.amount,
      );
      emit(DepositRequestSuccess(depositRequest));
    } catch (failure) {
      emit(DepositRequestError(_mapFailureToMessage(failure)));
    }
  }

  String _mapFailureToMessage(dynamic failure) {
    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again.';
    } else if (failure is HttpFailure) {
      return 'Network error. Please check your connection.';
    } else if (failure is DataFormatFailure) {
      return 'Invalid data format.';
    } else if (failure is NoDataFailure) {
      return 'No data available.';
    } else {
      return 'An unexpected error occurred.';
    }
  }
}
