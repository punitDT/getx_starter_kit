import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/providers/user_provider.dart';

import '../../../../core/widgets/snackbar_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends GetxController {
  AuthController(this._repository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthRepositoryImpl _repository;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await _repository.login(
        LoginRequestModel(email: email.trim(), password: password),
      );
      await UserProvider.setUser(result);
      SnackbarHelper.showSuccess('Welcome ${result.name}');
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final result = await _repository.register(
        LoginRequestModel(email: email.trim(), password: password),
      );
      await UserProvider.setUser(result);
      SnackbarHelper.showSuccess(
        'Account created successfully. Welcome ${result.name}',
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      SnackbarHelper.showError(e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    // clear local cached user + tokens
    await UserProvider.clearSession();
    Get.offAllNamed(AppRoutes.login);
    SnackbarHelper.showInfo('Logged out successfully');
  }
}
