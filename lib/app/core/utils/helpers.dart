import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  SnackbarHelper._();

  static void showSuccess(String message) {
    Get.snackbar('Success', message, snackPosition: SnackPosition.TOP, backgroundColor: const Color(0xFF2E7D32));
  }

  static void showError(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.TOP, backgroundColor: const Color(0xFFD32F2F));
  }

  static void showInfo(String message) {
    Get.snackbar('Info', message, snackPosition: SnackPosition.TOP, backgroundColor: const Color(0xFF1F3F7F));
  }
}
