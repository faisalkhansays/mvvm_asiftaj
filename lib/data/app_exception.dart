class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message$_message';
  }
}
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}
class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input request');
}
