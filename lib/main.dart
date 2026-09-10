import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_starter_kit/app/core/theme/desgin_config.dart';
import 'package:getx_starter_kit/app/core/transaltions/app_transalations.dart';
import 'package:logger/logger.dart';

import 'app/bindings/initial_binding.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
    () {
      runApp(const App());
    },
    (error, stackTrace) {
      final logger = Logger();
      logger.e('Unhandled app error', error: error, stackTrace: stackTrace);
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(
      DesignConfig.kDesignWidth,
      DesignConfig.kDesignHeight,
    ),
    minTextAdapt: true,
    splitScreenMode: true,
    child: GetMaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.products,
      getPages: AppPages.routes,
    ),
  );
}
