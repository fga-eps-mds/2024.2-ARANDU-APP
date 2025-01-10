import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';

class EditProfileService {
  static Future<void> edit(EditProfileRequest editProfileRequest) async {
    await BaseApi.getInstance(auth: false)
        .post(path: '/users', data: editProfileRequest.toJson());
  }
}
