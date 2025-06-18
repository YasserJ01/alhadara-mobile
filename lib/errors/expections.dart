//exceptions.dart
class ApiException implements Exception {
  final String message;
  final int statusCode;
  final dynamic response;

  ApiException(this.message, this.statusCode, [this.response]);

  @override
  String toString() => 'ApiException: $message (Status $statusCode)';
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException(this.errors);

  @override
  String toString() => errors.toString();
}
class ValidationnException implements Exception {
  final String errors;

  ValidationnException(this.errors);

  @override
  String toString() => errors.toString();
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);

  @override
  String toString() => message;
}
