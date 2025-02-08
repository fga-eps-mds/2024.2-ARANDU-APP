import 'package:aranduapp/ui/trails/service/trails_service.dart';
import 'package:aranduapp/ui/trails/viewmodel/trails_viewmodel.dart';
import 'package:get_it/get_it.dart';


void setupTrailsDI() {

  GetIt.instance.registerLazySingleton(() => TrailsService());
  GetIt.instance.registerFactory(() => TrailsViewmodel());

}
