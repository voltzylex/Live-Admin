import 'dart:developer';

abstract class ApiErrors implements Exception {
  final String message = "";
  ApiErrors({String? name}) {
    log(message, name: name ?? "");
  }
}

class UnknownError extends ApiErrors {
  @override
  String get message => "Unknown Error";
  UnknownError() : super(name: 'UnknownError');
}

class TimeoutError extends ApiErrors {
  @override
  TimeoutError() : super(name: 'TimeoutError');
}

class NoConnectionError extends ApiErrors {
  @override
  NoConnectionError() : super(name: 'NoConnectionError');
}

class UnauthorizedError extends ApiErrors {
  @override
  UnauthorizedError() : super(name: 'UnauthorizeError');
}

class ServerResError extends ApiErrors {
  @override
  // ignore: overridden_fields
  final String message;
  ServerResError(this.message) : super(name: 'ServerResError');
}
