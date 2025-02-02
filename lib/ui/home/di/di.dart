import 'package:aranduapp/ui/home/service/home_service.dart';
import 'package:aranduapp/ui/home/viewmodel/home_viewmodel.dart';
import 'package:get_it/get_it.dart';


void setupHomeDI() {

  GetIt.instance.registerLazySingleton(() => HomeService());
  GetIt.instance.registerFactory(() => HomeViewModel());

}
