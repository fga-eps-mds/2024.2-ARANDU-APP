import 'package:flutter/material.dart';

class TextPassWord extends StatefulWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor; // Cor de fundo padrão para modo claro.
  final Color darkBackgroundColor; // Cor de fundo para modo escuro.

  const TextPassWord({
    super.key,
    required this.padding,
    required this.controller,
    this.backgroundColor =
        const Color(0xfff7f8f8), // Cor padrão para modo claro.
    this.darkBackgroundColor =
        const Color(0xff1e1e1e), // Cor padrão para modo escuro.
  });

  @override
  State<StatefulWidget> createState() {
    return _TextPassWord();
  }
}

class _TextPassWord extends State<TextPassWord> {
  bool _hidePassord = true;

  @override
  Widget build(BuildContext context) {
    // Verifica o tema atual (claro ou escuro).
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          color:
              isDarkMode ? widget.darkBackgroundColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 8) {
              return 'Senha inválida';
            }
            return null;
          },
          controller: widget.controller,
          obscureText: _hidePassord,
          decoration: InputDecoration(
            border: InputBorder.none, // Remove a borda padrão.
            prefixIcon: Icon(
              Icons.lock_outline,
              color: const Color(0xffada4a5),
            ),
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                _hidePassord = !_hidePassord;
              }),
              child: Icon(
                _hidePassord
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xffada4a5),
              ),
            ),
            labelText: 'Senha',
          ),
        ),
      ),
    );
  }
}
