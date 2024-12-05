import 'package:aranduapp/core/theme/style/app_colors.dart';
import 'package:aranduapp/core/theme/style/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/core/theme/service/theme_provider.dart';
import 'package:aranduapp/config/ThemeApp.dart';
import 'package:aranduapp/ui/login/view/LoginView.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    AppColors.initialize(context);
    AppTypography.initialize(context);
    return MaterialApp(
      title: 'AranduApp',
      theme: ThemeApp.themeData(context),
      darkTheme: ThemeApp.darkThemeData(context),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Login(),
    );
  }
}
