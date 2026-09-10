import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<String> menuItems = <String>[
    'Dashboard',
    'Profile',
    'Settings',
  ].obs;

  // isLoading
  final RxBool isLoading = false.obs;

  void loadHome() {
    isLoading.value = true;
    isLoading.value = false;
  }
}
