import 'package:aranduapp/ui/register_account/service/register_service.dart';
import 'package:aranduapp/ui/register_account/viewmodel/register_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupRegisterDI() {

  GetIt.I.registerLazySingleton(() => RegisterService());

  GetIt.I.registerFactory(() => RegisterAccountViewModel());
}
