import 'package:aranduapp/ui/login/service/login_service.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLoginDI() {

  locator.registerLazySingleton(() => LoginService());

  locator.registerFactory(() => LoginViewModel());
}
