import 'package:aranduapp/core/log/Log.dart';
import 'package:aranduapp/ui/recover_account/model/RecoverAccountRequest.dart';
import 'package:aranduapp/ui/recover_account/service/RecoverAccountService.dart';
import 'package:flutter/material.dart';

class RecoverAccountViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKey;

  TextEditingController emailController;

  bool isLoading;

  RecoverAccountViewModel()
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        isLoading = false;

  Future<void> forgetPassword() async {
    // TODO use mutex to make this
    if (isLoading) {
      return;
    }

    try {
      isLoading = true;
      super.notifyListeners();

      if (!formKey.currentState!.validate()) {
        throw Exception('Valores inválidos');
      }

      await RecoverAccountService.forgetPassword(
          RecoverAccountRequest(emailController.text));
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      super.notifyListeners();
    }
  }
}
