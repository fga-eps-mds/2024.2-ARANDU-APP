import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/core/network/token_manager/service/auth_service.dart';
import 'package:get_it/get_it.dart';

void setupAuthDI() {
  GetIt.I.registerLazySingleton(() => AuthRepository());
  GetIt.I.registerFactory(() => AuthService());
}
