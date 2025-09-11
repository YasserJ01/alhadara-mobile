// withdrawal_event.dart
part of 'withdrawal_bloc.dart';
abstract class WithdrawalEvent extends Equatable {
  const WithdrawalEvent();

  @override
  List<Object> get props => [];
}

class WithdrawalAmountChanged extends WithdrawalEvent {
  final String amount;

  const WithdrawalAmountChanged(this.amount);

  @override
  List<Object> get props => [amount];
}

class WithdrawalSubmitted extends WithdrawalEvent {
  const WithdrawalSubmitted();
}