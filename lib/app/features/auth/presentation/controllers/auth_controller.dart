import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/providers/user_provider.dart';

import '../../../../core/base/base_controller.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/snackbar_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends BaseController {
  AuthController(this._repository);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthRepositoryImpl _repository;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    await callApi(() async {
      final result = await _repository.login(LoginRequestModel(email: email.trim(), password: password));

      switch (result) {
        case Success(:final value):
          await UserProvider.setUser(value);
          SnackbarHelper.showSuccess('Welcome ${value.name}');
          Get.offAllNamed(AppRoutes.home);
        case Failure(:final message):
          setError(message);
          SnackbarHelper.showError(message);
      }
    });
  }

  Future<void> register(String email, String password) async {
    await callApi(() async {
      final result = await _repository.register(LoginRequestModel(email: email.trim(), password: password));

      switch (result) {
        case Success(:final value):
          await UserProvider.setUser(value);
          SnackbarHelper.showSuccess('Account created for ${value.name}');
          Get.offAllNamed(AppRoutes.home);
        case Failure(:final message):
          setError(message);
          SnackbarHelper.showError(message);
      }
    });
  }

  Future<void> logout() async {
    await _repository.logout();
    // clear local cached user + tokens
    await UserProvider.clearSession();
    Get.offAllNamed(AppRoutes.login);
    SnackbarHelper.showInfo('Logged out successfully');
  }
}
