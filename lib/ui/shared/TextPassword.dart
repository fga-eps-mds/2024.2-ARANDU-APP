import 'package:flutter/material.dart';

class TextPassWord extends StatefulWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;

  const TextPassWord(
      {super.key, required this.padding, required this.controller});

  @override
  State<StatefulWidget> createState() {
    return _TextPassWord();
  }
}

class _TextPassWord extends State<TextPassWord> {
  bool _hidePassord = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo Obrigatório';
          } else if (value.length < 8) {
            return 'Mínimo 8 caracteres (Ex: @abd1234)';
          }
          return null;
        },
        controller: widget.controller,
        obscureText: _hidePassord,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline,
                color: Theme.of(context).colorScheme.primary),
            suffixIcon: GestureDetector(
                onTap: () => setState(() {
                      _hidePassord = !_hidePassord;
                    }),
                child: Icon(
                    _hidePassord
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Theme.of(context).colorScheme.primary)),
            labelText: 'Senha'),
      ),
    );
  }
}
