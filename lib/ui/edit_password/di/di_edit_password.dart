import 'package:aranduapp/ui/edit_password/service/edit_password_service.dart';
import 'package:aranduapp/ui/edit_password/viewmodel/edit_password_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupEditPasswordDI() {
  GetIt.I.registerLazySingleton(() => EditPasswordService());

  GetIt.I.registerFactory(() => EditPasswordViewModel());
}
