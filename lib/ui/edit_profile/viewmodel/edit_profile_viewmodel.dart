import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';
import 'package:aranduapp/ui/edit_profile/service/edit_profile_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditProfileViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;

  late Command0<void> editCommand;

  EditProfileViewModel()
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(),
        userNameController = TextEditingController(),
        emailController = TextEditingController() {
    editCommand = Command0<void>(editProfile);
  }

  Future<Result<void>> editProfile() async {
    if (!formKey.currentState!.validate()) {
      return Result.error(Exception('Valores inválidos'));
    }

    EditProfileRequest request = EditProfileRequest(
        name: nameController.text,
        userName: userNameController.text,
        email: emailController.text);

    await GetIt.instance<EditProfileService>().edit(request);

    return Result.value(null);
  }
}
