
import 'package:get/get.dart';

import '../services/logger_service.dart';

class AppLogger {
  AppLogger._();

  static LoggerService get logger => Get.find<LoggerService>();

  static void verbose(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.verbose(message, error, stackTrace);
  }

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.debug(message, error, stackTrace);
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.info(message, error, stackTrace);
  }

  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.warning(message, error, stackTrace);
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.error(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error, stackTrace);
  }
}