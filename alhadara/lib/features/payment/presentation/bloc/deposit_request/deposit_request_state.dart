// presentation/bloc/deposit_request_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/deposit_request.dart';

abstract class DepositRequestState extends Equatable {
  const DepositRequestState();

  @override
  List<Object> get props => [];
}

class DepositRequestInitial extends DepositRequestState {}

class DepositRequestLoading extends DepositRequestState {}

class DepositRequestSuccess extends DepositRequestState {
  final DepositRequest depositRequest;

  const DepositRequestSuccess(this.depositRequest);

  @override
  List<Object> get props => [depositRequest];
}

class DepositRequestError extends DepositRequestState {
  final String message;

  const DepositRequestError(this.message);

  @override
  List<Object> get props => [message];
}

