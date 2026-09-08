abstract class AppException implements Exception {
  const AppException({required this.message, this.code = 'app_exception'});

  final String message;
  final String code;
}
