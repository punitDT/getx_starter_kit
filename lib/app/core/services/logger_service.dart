import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoggerService extends GetxService {
  late final Logger _logger;

  @override
  void onInit() {
    super.onInit();
    _logger = Logger(
      printer: PrettyPrinter(
        lineLength: 180,
        methodCount: 0,
        errorMethodCount: 10,
      ),
    );
  }

  void verbose(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
