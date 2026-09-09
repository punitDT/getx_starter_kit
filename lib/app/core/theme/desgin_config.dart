import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Design configuration
class DesignConfig {
  DesignConfig._();

  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;

  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 999.0;

  static const double iconSM = 16.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;

  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;

  ///Width of the canvas from design
  static const double kDesignWidth = 1125;

  ///Height of the canvas from design
  static const double kDesignHeight = 2436;

  /// min width
  static double kMinWidth = kIsWeb ? 500 : Get.width;

  /// min width for font scalling
  static double kMinWidthForFont = kIsWeb ? 380 : Get.width;

  /// is phone
  static bool get isPhone => Get.context?.isPhone ?? false;

  /// is tablet
  static bool get isTablet => Get.context?.isTablet ?? false;

  /// is desktop BASED ON SCREEN WIDTH
  static bool get isDesktop => Get.width > kMinWidth;

  /// is web
  static bool get isWeb => kIsWeb;

}
