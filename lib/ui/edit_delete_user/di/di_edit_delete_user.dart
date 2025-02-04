import 'package:aranduapp/ui/edit_delete_user/service/edit_delete_user_service.dart';
import 'package:aranduapp/ui/edit_delete_user/viewmode/edit_delte_user_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupEditDeleteUser() {
  GetIt.I.registerLazySingleton(() => EditDeleteUserService());
  GetIt.I.registerLazySingleton(() => EditDelteUserViewmodel());
}
