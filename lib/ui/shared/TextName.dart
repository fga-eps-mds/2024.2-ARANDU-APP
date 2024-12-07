import 'package:flutter/material.dart';

class TextName  extends StatelessWidget{


  final TextEditingController controller;
  final EdgeInsetsGeometry padding;


  const TextName({ 
    super.key,
    required this.controller, 
    required this.padding,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding, 
      child: TextFormField(
        validator: (value) => value == null || value.trim().length < 3  ?  'Nome inválido' : null ,
        controller: controller,
        decoration: InputDecoration ( 
          prefixIcon: Icon ( Icons.person_outline, color: Theme.of(context).colorScheme.primary),
          labelText: 'Nome'
        ),
      ),
    );
  }

}
