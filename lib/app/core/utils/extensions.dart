import 'package:flutter/material.dart';

extension StringX on String {
  /// Returns true when the trimmed string is not empty.
  bool get isNotBlank => trim().isNotEmpty;

  /// Returns true when the string matches a basic email pattern.
  bool get isValidEmail => RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trim());
}

extension BuildContextX on BuildContext {
  ThemeData get appTheme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension DateTimeX on DateTime {
  /// Returns a normalized future payload date for token expiry.
  DateTime get safeExpiry => isAfter(DateTime.now()) ? this : DateTime.now().add(const Duration(hours: 1));
}
