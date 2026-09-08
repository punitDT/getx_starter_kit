import 'package:get/get.dart';

import '../errors/app_exception.dart';
import '../widgets/snackbar_helper.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  void showLoading() => isLoading.value = true;

  void hideLoading() => isLoading.value = false;

  void setError(String message) {
    hasError.value = true;
    errorMessage.value = message;
  }

  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }

  Future<void> callApi(Future<void> Function() action) async {
    showLoading();
    clearError();
    try {
      await action();
    } on AppException catch (e) {
      setError(e.message);
      SnackbarHelper.showError(e.message);
    } catch (e) {
      const message = 'Something went wrong. Please try again.';
      setError(message);
      SnackbarHelper.showError(message);
    } finally {
      hideLoading();
    }
  }
}
