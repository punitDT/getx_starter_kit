import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';

class HomeController extends BaseController {
  final RxList<String> menuItems = <String>['Dashboard', 'Profile', 'Settings'].obs;

  void loadHome() {
    showLoading();
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      hideLoading();
    });
  }
}
