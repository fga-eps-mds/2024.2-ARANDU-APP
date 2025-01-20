import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';
import 'package:aranduapp/ui/edit_profile/service/edit_profile_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditProfileViewModel extends ChangeNotifier {
  late Command1<void, EditProfileRequest> editCommand;

  EditProfileViewModel() {
    editCommand = Command1<void, EditProfileRequest>(editProfile);
  }

  Future<Result<void>> editProfile(EditProfileRequest request) async {
    await GetIt.instance<EditProfileService>().edit(request);
    return Result.value(null);
  }
}
