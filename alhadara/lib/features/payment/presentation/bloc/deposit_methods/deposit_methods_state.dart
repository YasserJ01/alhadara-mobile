// presentation/pages/deposit/bloc/deposit_methods_state.dart
part of 'deposit_methods_bloc.dart';

abstract class DepositState extends Equatable {
  const DepositState();

  @override
  List<Object> get props => [];
}

class DepositInitial extends DepositState {}

class DepositLoading extends DepositState {}

class DepositLoaded extends DepositState {
  final List<DepositMethodEntity> methods;
  final DepositMethodEntity? selectedMethod;
  final BankInfoEntity? selectedBank;
  final TransferInfoEntity? selectedCompany;

  const DepositLoaded({
    required this.methods,
    this.selectedMethod,
    this.selectedBank,
    this.selectedCompany,
  });

  @override
  List<Object> get props => [
        methods,
        selectedMethod ?? '',
        selectedBank ?? '',
        selectedCompany ?? '',
      ];
}

class DepositError extends DepositState {
  final String message;

  const DepositError(this.message);

  @override
  List<Object> get props => [message];
}