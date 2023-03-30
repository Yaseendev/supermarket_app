//
import 'package:flutter/material.dart';

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF146C94);
  static const Color BACKGROUND_COLOR = Color(0xFFF7F8F9);
  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_SWATCH =
      MaterialColor(AppColors.PRIMARY_COLOR.value, <int, Color>{
    50: PRIMARY_COLOR,
    100: PRIMARY_COLOR,
    200: PRIMARY_COLOR,
    300: PRIMARY_COLOR,
    400: PRIMARY_COLOR,
    500: PRIMARY_COLOR,
    600: PRIMARY_COLOR,
    700: PRIMARY_COLOR,
    800: PRIMARY_COLOR,
    900: PRIMARY_COLOR,
  });
}

class AppImages {
  static const String rootUri = 'assets/images';
  static const logoTransparent = '$rootUri/logo_transparent.png';
  static const logo = '$rootUri/logo.png';
}
