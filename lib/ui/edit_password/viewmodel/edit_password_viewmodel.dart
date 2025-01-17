import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_password/model/edit_password_request.dart';
import 'package:aranduapp/ui/edit_password/service/edit_password_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditPasswordViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController oldPasswordController;

  late Command0<void> editCommand;

  EditPasswordViewModel()
      : formKey = GlobalKey<FormState>(),
        newPasswordController = TextEditingController(),
        oldPasswordController = TextEditingController() {
    editCommand = Command0<void>(editPassword);
  }

  Future<Result<void>> editPassword() async {
    if (!formKey.currentState!.validate()) {
      return Result.error(Exception('Valores inválidos'));
    }

    EditPasswordRequest request = EditPasswordRequest(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text);

    await GetIt.instance<EditPasswordService>().edit(request);

    return Result.value(null);
  }
}
