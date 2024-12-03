import 'package:flutter/material.dart';

class TextEmail extends StatelessWidget{


  final TextEditingController controller;
  final EdgeInsetsGeometry padding;

    static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+\w{2,4}$');


  const TextEmail ({
    super.key,
    required this.padding,
    required this.controller
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, 
      child: TextFormField(
        validator: (value) => value == null|| emailRegex.hasMatch(value) ? null : 'E-mail inválido',
        controller: controller,
        decoration: InputDecoration ( 
          prefixIcon: Icon ( Icons.email_outlined, color: Theme.of(context).colorScheme.primary),
          labelText: 'E-mail'
        ),
      ),
    );
  }

}
