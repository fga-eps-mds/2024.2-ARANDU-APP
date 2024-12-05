import 'package:flutter/material.dart';
import 'package:aranduapp/core/theme/style/app_colors.dart';
import 'package:aranduapp/core/theme/style/app_typography.dart';

class ThemeApp {
  static ThemeData themeData(BuildContext context) {
    AppColors.initialize(context);
    AppTypography.initialize(context);

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.current.tituloApp,
      scaffoldBackgroundColor: AppColors.current.background,
      textTheme: TextTheme(
        displayLarge: AppTypography.current.title28,
        displayMedium: AppTypography.current.title26,
        titleMedium: AppTypography.current.subtitle22,
        bodyLarge: AppTypography.current.text16,
        bodyMedium: AppTypography.current.text14,
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.current.tituloApp,
        secondary: AppColors.current.losang,
        surface: AppColors.current.background,
        onPrimary: AppColors.current.text,
        onSecondary: AppColors.current.text,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.current.text,
          backgroundColor: AppColors.current.secBackground,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.current.losang,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.current.background,
          backgroundColor: AppColors.current.tituloApp,
        ),
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    AppColors.initialize(context);
    AppTypography.initialize(context);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.current.tituloApp,
      scaffoldBackgroundColor: AppColors.current.background,
      textTheme: TextTheme(
        displayLarge: AppTypography.current.title28,
        displayMedium: AppTypography.current.title26,
        titleMedium: AppTypography.current.subtitle22,
        bodyLarge: AppTypography.current.text16,
        bodyMedium: AppTypography.current.text14,
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.current.tituloApp,
        secondary: AppColors.current.losang,
        surface: AppColors.current.background,
        onPrimary: AppColors.current.text,
        onSecondary: AppColors.current.text,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.current.text,
          backgroundColor: AppColors.current.secBackground,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.current.losang,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.current.background,
          backgroundColor: AppColors.current.tituloApp,
        ),
      ),
    );
  }
}
