import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:aranduapp/ui/home/viewmodel/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupHomeDI() {
  locator.registerLazySingleton(() => HomeService());
  locator.registerFactory(() => HomeViewModel());
}
