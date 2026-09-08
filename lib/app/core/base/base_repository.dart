import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import '../errors/network_exception.dart';

abstract class BaseRepository {
  AppException mapException(DioException exception) {
    final responseData = exception.response?.data;
    final dynamicMessage = responseData is Map<String, dynamic>
        ? responseData['message']?.toString() ?? 'Unknown error'
        : null;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NoInternetException();
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case 400:
            return BadRequestException(message: dynamicMessage ?? 'Bad request');
          case 401:
            return const UnauthorizedException();
          case 403:
            return const ForbiddenException();
          case 404:
            return const NotFoundException();
          case 422:
            return ValidationException(message: dynamicMessage ?? 'Validation failed');
          case 500:
          case 502:
          case 503:
          case 504:
            return const ServerException();
          default:
            return const ServerException();
        }
      case DioExceptionType.cancel:
        return const RequestCancelledException();
      case DioExceptionType.unknown:
      default:
        return const ServerException();
    }
  }
}
