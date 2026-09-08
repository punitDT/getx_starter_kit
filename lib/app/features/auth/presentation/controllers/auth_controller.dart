import 'package:get/get.dart';

import '../../../../core/base/base_controller.dart';
import 'package:getx_starter_kit/app/core/helpers/auth.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/snackbar_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends BaseController {
  AuthController(this._repository);

  final AuthRepositoryImpl _repository;

  Future<void> login(String email, String password) async {
    await callApi(() async {
      final result = await _repository.login(LoginRequestModel(email: email.trim(), password: password));

      switch (result) {
        case Success(:final value):
          await Auth.setUser(value);
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
          await Auth.setUser(value);
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
    await Auth.clearSession();
    Get.offAllNamed(AppRoutes.login);
    SnackbarHelper.showInfo('Logged out successfully');
  }
}
