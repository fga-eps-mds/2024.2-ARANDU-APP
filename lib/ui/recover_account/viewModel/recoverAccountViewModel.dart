import 'package:flutter/material.dart';

class RecoverAccountViewModel extends ChangeNotifier {
  final BuildContext context;

  final formKey;

  final emailController;

  RecoverAccountViewModel(this.context)
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController();
}
