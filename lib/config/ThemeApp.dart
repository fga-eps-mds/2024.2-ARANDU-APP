import 'dart:ui';
import 'package:flutter/material.dart';

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class ThemeApp {
  static var textTheme = const TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
  );

  static ThemeData themeData() {
    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: fromHex("#F97316"),
      surfaceTint: fromHex("#C05621"),
      onPrimary: fromHex("#FFFFFF"),
      primaryContainer: fromHex("#F58634"),
      onPrimaryContainer: fromHex("#1D1617"),
      secondary: fromHex("#63B3ED"),
      onSecondary: fromHex("#FFFFFF"),
      secondaryContainer: fromHex("#3182CE"),
      onSecondaryContainer: fromHex("#1D1617"),
      tertiary: fromHex("#D4B139"),
      onTertiary: fromHex("#1D1617"),
      tertiaryContainer: fromHex("#FFF8E1"),
      onTertiaryContainer: fromHex("#7B6F72"),
      error: fromHex("#C00F0C"),
      onError: fromHex("#FFFFFF"),
      errorContainer: fromHex("#F2BFBF"),
      onErrorContainer: fromHex("#B71C1C"),
      surface: fromHex("#FFFFFF"),
      onSurface: fromHex("#ada4a5"),
      outline: fromHex("#ADA4A5"),
      shadow: fromHex("#000000"),
      inverseSurface: fromHex("#303030"),
      inversePrimary: fromHex("#FFC107"),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: scheme.onPrimary,
          backgroundColor: scheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface.withOpacity(0.1),
        labelStyle: TextStyle(color: scheme.primary),
        hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.primary),
        ),
      ),
    );
  }

  static ThemeData darkThemeData() {
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: fromHex("#F97316"),
      surfaceTint: fromHex("#DD6B20"),
      onPrimary: fromHex("#1D1617"),
      primaryContainer: fromHex("#F58634"),
      onPrimaryContainer: fromHex("#1D1617"),
      secondary: fromHex("#4FD1C5"),
      onSecondary: fromHex("#1D1617"),
      secondaryContainer: fromHex("#81E6D9"),
      onSecondaryContainer: fromHex("#1D1617"),
      tertiary: fromHex("#DAC17D"),
      onTertiary: fromHex("#1D1617"),
      tertiaryContainer: fromHex("#EEDC82"),
      onTertiaryContainer: fromHex("#7B6F72"),
      error: fromHex("#FF6B6B"),
      onError: fromHex("#1D1617"),
      errorContainer: fromHex("#F2BFBF"),
      onErrorContainer: fromHex("#B71C1C"),
      surface: fromHex("#181818"),
      onSurface: fromHex("#FFFFFF"),
      outline: fromHex("#ADA4A5"),
      shadow: fromHex("#000000"),
      inverseSurface: fromHex("#F5F5F5"),
      inversePrimary: fromHex("#FFA726"),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      textTheme: textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: scheme.onPrimary,
          backgroundColor: scheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface.withOpacity(0.1),
        labelStyle: TextStyle(color: scheme.primary),
        hintStyle: TextStyle(color: scheme.onSurface.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.primary),
        ),
      ),
    );
  }
}
