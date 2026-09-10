import 'package:get/get.dart';
import 'package:getx_starter_kit/app/features/product/presentation/views/products_view.dart';

import '../features/auth/presentation/bindings/auth_binding.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/home/presentation/home_binding.dart';
import '../features/home/presentation/home_view.dart';
import '../features/home/presentation/profile_view.dart';
import '../features/product/presentation/bindings/products_binding.dart';
import '../features/splash/presentation/splash_binding.dart';
import '../features/splash/presentation/splash_view.dart';
import '../routes/middlewares/auth_middleware.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
