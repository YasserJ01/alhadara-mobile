//failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class ValidationFailure extends Failure {}

class CacheFailure extends Failure {}

class NoDataFailure extends Failure {}

class DataFormatFailure extends Failure {}

class HttpFailure extends Failure {}

class NoInternetFailure extends Failure {
  @override
  List<Object> get props => [];
}


class LocalStorageFailure extends Failure {
  final String message;

  LocalStorageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);

  @override
  List<Object> get props => [message];
}

class NotFoundFailure extends Failure {
  final String message;

  NotFoundFailure(this.message);

  @override
  List<Object> get props => [message];
}
