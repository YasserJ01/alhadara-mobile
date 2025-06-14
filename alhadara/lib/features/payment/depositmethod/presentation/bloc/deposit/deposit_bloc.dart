// presentation/pages/deposit/bloc/deposit_bloc.dart
import 'package:alhadara/features/payment/depositmethod/domain/entities/deposit_method_entity.dart';
import 'package:alhadara/features/payment/depositmethod/domain/usecases/get_deposit_methods.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'deposit_event.dart';
part 'deposit_state.dart';

class DepositBloc extends Bloc<DepositEvent, DepositState> {
  final GetDepositMethods getDepositMethods;

  DepositBloc({required this.getDepositMethods}) : super(DepositInitial()) {
    on<LoadDepositMethods>(_onLoadDepositMethods);
    on<SelectMethodType>(_onSelectMethodType);
    on<SelectBank>(_onSelectBank);
    on<SelectTransferCompany>(_onSelectTransferCompany);
  }

  Future<void> _onLoadDepositMethods(
    LoadDepositMethods event,
    Emitter<DepositState> emit,
  ) async {
    emit(DepositLoading());
    try {
      final methods = await getDepositMethods();
      emit(DepositLoaded(methods: methods));
    } catch (e) {
      emit(DepositError('Failed to load deposit methods'));
    }
  }

  void _onSelectMethodType(
    SelectMethodType event,
    Emitter<DepositState> emit,
  ) {
    if (state is DepositLoaded) {
      final currentState = state as DepositLoaded;
      emit(
        currentState.copyWith(
          selectedMethod: event.method,
          selectedBank: null,
          selectedCompany: null,
        ),
      );
    }
  }

  void _onSelectBank(
    SelectBank event,
    Emitter<DepositState> emit,
  ) {
    if (state is DepositLoaded) {
      final currentState = state as DepositLoaded;
      emit(
        currentState.copyWith(selectedBank: event.bank),
      );
    }
  }

  void _onSelectTransferCompany(
    SelectTransferCompany event,
    Emitter<DepositState> emit,
  ) {
    if (state is DepositLoaded) {
      final currentState = state as DepositLoaded;
      emit(
        currentState.copyWith(selectedCompany: event.company),
      );
    }
  }
}

extension DepositLoadedX on DepositLoaded {
  DepositLoaded copyWith({
    List<DepositMethodEntity>? methods,
    DepositMethodEntity? selectedMethod,
    BankInfoEntity? selectedBank,
    TransferInfoEntity? selectedCompany,
  }) {
    return DepositLoaded(
      methods: methods ?? this.methods,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      selectedBank: selectedBank ?? this.selectedBank,
      selectedCompany: selectedCompany ?? this.selectedCompany,
    );
  }
}