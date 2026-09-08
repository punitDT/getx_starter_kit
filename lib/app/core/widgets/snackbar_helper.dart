import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  SnackbarHelper._();

  static void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: const Color(0xFF2E7D32),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  static void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: const Color(0xFFD32F2F),
      colorText: Colors.white,
    );
  }

  static void showInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      backgroundColor: const Color(0xFF1F3F7F),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
