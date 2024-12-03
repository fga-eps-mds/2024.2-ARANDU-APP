import 'package:flutter/material.dart';

// TODO: colcar o nosso tema e tirar essas duas dependencia
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {

 static var textTheme =  const TextTheme( 
    headlineLarge: TextStyle (
      fontWeight: FontWeight.w700,
      fontSize: 36
    ),
  );


 static themeData(){
    return FlexThemeData.light(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,

        textTheme:  textTheme,

        appBarBackground: FlexColor.redWineLightPrimary

         
      );

    
  }

 static darkThemeData(){
      return FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,


        textTheme:  textTheme,

        appBarBackground: FlexColor.redWineDarkPrimary
      );   
  }

}
