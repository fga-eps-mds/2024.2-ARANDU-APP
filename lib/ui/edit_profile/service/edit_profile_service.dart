import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';

class EditProfileService {
  Future<void> edit(EditProfileRequest editProfileRequest) async {
    await AuthApi.getInstance(auth: true)
        .patch(path: '/users', data: editProfileRequest.toJson());
  }
}
