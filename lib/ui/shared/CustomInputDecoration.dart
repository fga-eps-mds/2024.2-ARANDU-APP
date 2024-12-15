import 'package:flutter/material.dart';

InputDecoration customInputDecoration({
  required String labelText,
  Widget? prefixIcon,
  GestureDetector? suffixIcon,
}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.circular(14.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
      borderRadius: BorderRadius.circular(14.0),
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 44, 44, 44),
  );
}
