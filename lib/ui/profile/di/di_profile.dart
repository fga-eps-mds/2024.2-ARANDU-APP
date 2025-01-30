import 'package:aranduapp/ui/profile/viewmodel/profile_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupProfileDI() {
  GetIt.I.registerLazySingleton(() => ProfileViewModel());
}
