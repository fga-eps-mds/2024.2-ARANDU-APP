import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:aranduapp/ui/edit_profile/service/EditProfileService.dart';
import 'package:aranduapp/ui/edit_profile/model/EditProfileRequest.dart';

import 'package:aranduapp/ui/home/view/HomeView.dart';

class EditProfileViewModel extends ChangeNotifier {
  final BuildContext context;

  bool isLoading;

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  EditProfileViewModel(this.context)
      : isLoading = false,
        formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();
}
