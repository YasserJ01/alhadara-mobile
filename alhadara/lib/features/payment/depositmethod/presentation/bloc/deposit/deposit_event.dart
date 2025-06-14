// presentation/pages/deposit/bloc/deposit_event.dart
part of 'deposit_bloc.dart';

abstract class DepositEvent extends Equatable {
  const DepositEvent();

  @override
  List<Object> get props => [];
}

class LoadDepositMethods extends DepositEvent {}

class SelectMethodType extends DepositEvent {
  final DepositMethodEntity method;

  const SelectMethodType(this.method);

  @override
  List<Object> get props => [method];
}

class SelectBank extends DepositEvent {
  final BankInfoEntity bank;

  const SelectBank(this.bank);

  @override
  List<Object> get props => [bank];
}

class SelectTransferCompany extends DepositEvent {
  final TransferInfoEntity company;

  const SelectTransferCompany(this.company);

  @override
  List<Object> get props => [company];
}