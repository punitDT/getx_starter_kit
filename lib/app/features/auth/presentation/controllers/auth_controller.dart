import 'package:get/get.dart';

import '../../../../core/base/base_controller.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/widgets/snackbar_helper.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class AuthController extends BaseController {
  AuthController(this._repository);

  final AuthRepositoryImpl _repository;
  final SecureStorageService _secureStorageService = const SecureStorageService();

  Future<void> login(String email, String password) async {
    await callApi(() async {
      final user = await _repository.login(LoginRequestModel(email: email.trim(), password: password));
      await _secureStorageService.saveTokens(
        access: 'demo_access_token',
        refresh: 'demo_refresh_token',
        expiry: DateTime.now().add(const Duration(hours: 1)),
      );
      SnackbarHelper.showSuccess('Welcome ${user.name}');
      Get.offAllNamed('/home');
    });
  }

  Future<void> register(String email, String password) async {
    await callApi(() async {
      final user = await _repository.register(LoginRequestModel(email: email.trim(), password: password));
      SnackbarHelper.showSuccess('Account created for ${user.name}');
      Get.offAllNamed('/home');
    });
  }

  Future<void> logout() async {
    await _repository.logout();
    Get.offAllNamed('/login');
    SnackbarHelper.showInfo('Logged out successfully');
  }
}
