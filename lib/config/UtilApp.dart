import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    'Comfortaa',
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    'Amarante',
    baseTextTheme,
  );
  TextTheme subtitleTextTheme = GoogleFonts.getTextTheme(
    'Dosis',
    baseTextTheme,
  );

  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
    titleLarge: subtitleTextTheme.titleLarge,
    titleMedium: subtitleTextTheme.titleMedium,
    titleSmall: subtitleTextTheme.titleSmall,
  );

  return textTheme;
}
