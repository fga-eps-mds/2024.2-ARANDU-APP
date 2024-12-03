import 'package:aranduapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static late _Typography typography;

  // Inicialização de acordo com o tema
  static void initialize(BuildContext context) {
    typography = (Theme.of(context).brightness == Brightness.dark)
        ? _darkTypography(context)
        : _lightTypography(context);
  }

  static _Typography get current => typography;

  // Função para tipografia para o tema claro
  static _Typography _lightTypography(BuildContext context) {
    final colors = AppColors.current; // Obter as cores do tema atual
    return _Typography(
      titleH1: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.bold, // Peso para título H1
        fontSize: 26,
        color: colors.tituloApp, // Usar a cor definida para o título
      ),
      titleH1SemiBold: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.w600, // Semi-bold para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
      titleH1Medium: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.w500, // Medium para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
      titleH1Regular: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.normal, // Regular para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
    );
  }

  // Função para tipografia para o tema escuro
  static _Typography _darkTypography(BuildContext context) {
    final colors = AppColors.current; // Obter as cores do tema atual
    return _Typography(
      titleH1: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: colors.tituloApp, // Usar a cor do tema escuro
      ),
      titleH1SemiBold: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.w600, // Semi-bold para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
      titleH1Medium: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.w500, // Medium para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
      titleH1Regular: TextStyle(
        fontFamily: 'Amarante',
        fontWeight: FontWeight.normal, // Regular para título H1
        fontSize: 26,
        color: colors.tituloApp,
      ),
    );
  }
}

// Classe que armazena as configurações de tipografia divididas por Títulos e Subtítulos
class _Typography {
  final TextStyle titleH1;
  final TextStyle titleH1SemiBold;
  final TextStyle titleH1Medium;
  final TextStyle titleH1Regular;

  _Typography({
    required this.titleH1,
    required this.titleH1SemiBold,
    required this.titleH1Medium,
    required this.titleH1Regular,
  });
}
