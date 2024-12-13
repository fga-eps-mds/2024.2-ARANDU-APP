import 'package:aranduapp/ui/recover_account/model/RecoverAccountRequest.dart';
import 'package:aranduapp/ui/recover_account/service/RecoverAccountService.dart';
import 'package:flutter/material.dart';

class RecoverAccountViewModel extends ChangeNotifier {
  final BuildContext context;

  final formKey;

  final emailController;

  final recoverAccountService;

  bool isLoading;

  RecoverAccountViewModel(this.context)
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        recoverAccountService = RecoverAccountService(),
        isLoading = false;



  Future<void> forgetPassword(String email) async {

    // TODO use mutex to make this
    if (isLoading){
      return;
    }

    try {
      isLoading = true;
      super.notifyListeners();

      if (!formKey.currentState!.validate()) {
        throw Exception('Valores inválidos');
      }

      await recoverAccountService.forgetPassword(RecoverAccountRequest(email));

    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      super.notifyListeners();
    }





  }
}
