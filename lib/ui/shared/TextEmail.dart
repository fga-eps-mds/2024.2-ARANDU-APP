import 'package:flutter/material.dart';

class TextEmail extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final Color lightBackgroundColor; // Cor de fundo para modo claro.
  final Color darkBackgroundColor; // Cor de fundo para modo escuro.

  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+\w{2,4}$');

  const TextEmail({
    super.key,
    required this.padding,
    required this.controller,
    this.lightBackgroundColor = const Color(0xfff7f8f8), // Padrão: modo claro.
    this.darkBackgroundColor = const Color(0xff1e1e1e), // Padrão: modo escuro.
  });

  @override
  Widget build(BuildContext context) {
    // Verifica se o tema é escuro.
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? darkBackgroundColor : lightBackgroundColor,
          borderRadius: BorderRadius.circular(8), // Bordas arredondadas.
        ),
        child: TextFormField(
          validator: (value) => value == null || emailRegex.hasMatch(value)
              ? null
              : 'E-mail inválido',
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove a borda padrão.
            prefixIcon: Icon(
              Icons.email_outlined,
              color: const Color(0xffada4a5),
            ),
            labelText: 'E-mail',
          ),
        ),
      ),
    );
  }
}
