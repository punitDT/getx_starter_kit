import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/providers/user_provider.dart';
import '../app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final authenticated = await UserProvider.isAuthenticated();

    if (!authenticated) {
      return GetNavConfig.fromRoute(AppRoutes.login);
    }
    return null;
  }
}
