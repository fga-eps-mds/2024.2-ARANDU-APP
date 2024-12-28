import 'package:flutter/material.dart';

class TextEmail extends StatelessWidget{

  final String label;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;

    static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+\w{2,4}$');


  const TextEmail ({
    super.key,
    this.label = 'E-mail',
    required this.padding,
    required this.controller,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, 
      child: TextFormField(
        validator: (value) { 
          if (value == null || value.trim().isEmpty) {
            return '$label Obrigatório.';
          } else if (!emailRegex.hasMatch(value.trim())) {
            return 'Opa, $label inválido!\n(Ex: exemplo@gmail.com)';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration ( 
          prefixIcon: Icon ( Icons.email_outlined, color: Theme.of(context).colorScheme.primary),
          labelText: label),
      ),
    );
  }

}
