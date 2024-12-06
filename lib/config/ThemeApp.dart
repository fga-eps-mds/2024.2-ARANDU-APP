import 'package:flutter/material.dart';

class ThemeApp {
  static var textTheme = const TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
  );

  static ThemeData themeData() {
    final scheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF58634),
      surfaceTint: Color(0xFFC05621),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFF58634),
      onPrimaryContainer: Color(0xFF1D1617),
      secondary: Color(0xFF63B3ED),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF3182CE),
      onSecondaryContainer: Color(0xFF1D1617),
      tertiary: Color(0xFFD4B139),
      onTertiary: Color(0xFF1D1617),
      tertiaryContainer: Color(0xFFFFF8E1),
      onTertiaryContainer: Color(0xFF7B6F72),
      error: Color(0xFFC00F0C),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFF2BFBF),
      onErrorContainer: Color(0xFFB71C1C),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1D1617),
      background: Color(0xFFF5F5F5),
      onBackground: Color(0xFF1D1617),
      outline: Color(0xFFADA4A5),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFF303030),
      inversePrimary: Color(0xFFFFC107),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: scheme.background,
      canvasColor: scheme.surface,
    );
  }

  static ThemeData darkThemeData() {
    final scheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFC069),
      surfaceTint: Color(0xFFDD6B20),
      onPrimary: Color(0xFF1D1617),
      primaryContainer: Color(0xFFF58634),
      onPrimaryContainer: Color(0xFF1D1617),
      secondary: Color(0xFF4FD1C5),
      onSecondary: Color(0xFF1D1617),
      secondaryContainer: Color(0xFF81E6D9),
      onSecondaryContainer: Color(0xFF1D1617),
      tertiary: Color(0xFFDAC17D),
      onTertiary: Color(0xFF1D1617),
      tertiaryContainer: Color(0xFFEEDC82),
      onTertiaryContainer: Color(0xFF7B6F72),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF1D1617),
      errorContainer: Color(0xFFF2BFBF),
      onErrorContainer: Color(0xFFB71C1C),
      surface: Color(0xFF1D1617),
      onSurface: Color(0xFFFFFFFF),
      background: Color(0xFF1D1617),
      onBackground: Color(0xFFFFFFFF),
      outline: Color(0xFFADA4A5),
      shadow: Color(0xFF000000),
      inverseSurface: Color(0xFFF5F5F5),
      inversePrimary: Color(0xFFFFA726),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: scheme.background,
      canvasColor: scheme.surface,
    );
  }
}
