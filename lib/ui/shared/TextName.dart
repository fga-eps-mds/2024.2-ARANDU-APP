import 'package:flutter/material.dart';

class TextName extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;

  const TextName({
    super.key,
    this.label = 'Nome',
    required this.controller,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Campo Obrigatório';
            } else if (value.trim().length < 3) {
              return 'Nome inválido (Ex: Ana)';
            }
            return null;
        },
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline,
                color: Theme.of(context).colorScheme.primary),
            labelText: label),
      ),
    );
  }
}
