import 'package:aranduapp/ui/edit_profile/service/edit_profile_service.dart';
import 'package:aranduapp/ui/edit_profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupEditProfileDI() {
  locator.registerLazySingleton(() => EditProfileService());
  locator.registerFactory(() => EditProfileViewModel());
}
