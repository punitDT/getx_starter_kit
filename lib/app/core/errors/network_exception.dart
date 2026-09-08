import 'app_exception.dart';

class TimeoutException extends AppException {
  const TimeoutException() : super(message: 'Request timed out. Please try again.', code: 'timeout');
}

class NoInternetException extends AppException {
  const NoInternetException() : super(message: 'No internet connection.', code: 'no_internet');
}

class BadRequestException extends AppException {
  const BadRequestException({required super.message}) : super(code: 'bad_request');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super(message: 'Session expired. Please log in again.', code: 'unauthorized');
}

class ForbiddenException extends AppException {
  const ForbiddenException() : super(message: 'You do not have permission.', code: 'forbidden');
}

class NotFoundException extends AppException {
  const NotFoundException() : super(message: 'Resource not found.', code: 'not_found');
}

class ValidationException extends AppException {
  const ValidationException({required super.message}) : super(code: 'validation');
}

class ServerException extends AppException {
  const ServerException() : super(message: 'Server error. Please try later.', code: 'server');
}

class RequestCancelledException extends AppException {
  const RequestCancelledException() : super(message: 'Request cancelled.', code: 'cancelled');
}
