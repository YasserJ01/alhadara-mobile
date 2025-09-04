// presentation/pages/withdraw/bloc/withdrawal_state.dart
part of 'withdrawal_bloc.dart';

class WithdrawalState extends Equatable {
  final String amount;
  final FormSubmissionStatus formStatus;

  const WithdrawalState({
    this.amount = '',
    this.formStatus = const InitialFormStatus(),
  });

  WithdrawalState copyWith({
    String? amount,
    FormSubmissionStatus? formStatus,
  }) {
    return WithdrawalState(
      amount: amount ?? this.amount,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object> get props => [amount, formStatus];
}

abstract class FormSubmissionStatus extends Equatable {
  const FormSubmissionStatus();

  @override
  List<Object> get props => [];
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {
  const FormSubmitting();
}

class SubmissionSuccess extends FormSubmissionStatus {
  final WithdrawalEntity withdrawal;

  const SubmissionSuccess(this.withdrawal);

  @override
  List<Object> get props => [withdrawal];
}

class SubmissionFailed extends FormSubmissionStatus {
  final Failure failure;

  const SubmissionFailed(this.failure);

  @override
  List<Object> get props => [failure];
}