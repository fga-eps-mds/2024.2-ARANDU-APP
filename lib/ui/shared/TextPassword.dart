import 'package:flutter/material.dart';

class TextPassWord extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;

  const TextPassWord({
    super.key, 
    this.label = 'Senha',
    required this.padding, 
    required this.controller,
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
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} Obrigatória.';
          } else if (value.length < 8) {
            return '${widget.label} deve ter no mínimo 8 caracteres. (Ex: @abd1234)';
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
            labelText: widget.label,
        ),
      ),
    );
  }
}
