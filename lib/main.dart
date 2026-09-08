import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'app/bindings/initial_binding.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/translations/app_translations.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await GetStorage.init();

  runZonedGuarded(() {
    runApp(const App());
  }, (error, stackTrace) {
    final logger = Logger();
    logger.e('Unhandled app error', error: error, stackTrace: stackTrace);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = dotenv.isInitialized ? (dotenv.env['APP_NAME'] ?? 'GetX Starter Kit') : 'GetX Starter Kit';

    return GetMaterialApp(
      title: appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
