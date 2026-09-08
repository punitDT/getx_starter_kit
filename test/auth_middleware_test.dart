import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import 'package:getx_starter_kit/app/routes/middlewares/auth_middleware.dart';
import 'package:getx_starter_kit/app/core/helpers/auth.dart';

void main() {
  setUp(() {
    // reset test overrides
    Auth.testIsAuthenticated = null;
    Auth.testAccessToken = null;
    Auth.testClearSession = null;

    // ensure Get has at least the login route so GetNavConfig.fromRoute works
    Get.addPages([
      GetPage(name: '/login', page: () => const SizedBox()),
      GetPage(name: '/home', page: () => const SizedBox()),
    ]);
  });
  test('redirects to login when not authenticated', () async {
    Auth.testIsAuthenticated = () async => false;
    final middleware = AuthMiddleware();
    final result = await middleware.redirectDelegate(GetNavConfig.fromRoute('/home')!);
    expect(result, isNotNull);
  });

  test('allows navigation when authenticated', () async {
    Auth.testIsAuthenticated = () async => true;
    final middleware = AuthMiddleware();
    final result = await middleware.redirectDelegate(GetNavConfig.fromRoute('/home')!);
    expect(result, isNull);
  });
}
