import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';
import 'package:aranduapp/ui/edit_profile/service/edit_profile_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditProfileViewModel extends ChangeNotifier {
  late Command1<void, EditProfileRequest> editCommand;
  late Command0<void> getUserCommand;

  UserModel? user;

  EditProfileViewModel() {
    editCommand = Command1<void, EditProfileRequest>(editProfile);
    getUserCommand = Command0<void>(getUser);

    getUserCommand.execute();
  }

  Future<Result<void>> editProfile(EditProfileRequest request) async {
    await GetIt.instance<EditProfileService>().edit(request);

    await GetIt.instance<AuthRepository>().clearUser();
    return Result.value(null);
  }

  Future<Result<UserModel>> getUser() async {
    UserModel user = await GetIt.instance<AuthRepository>().getUser();
    _setUser(user);
    return Result.value(user);
  }

  void _setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }
}
