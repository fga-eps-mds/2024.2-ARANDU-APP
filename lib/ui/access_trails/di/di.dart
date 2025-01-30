import 'package:aranduapp/ui/access_trails/service/access_trails_service.dart';
import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
import 'package:get_it/get_it.dart';


void setupAccessTrails() {

  GetIt.instance.registerLazySingleton(() => AccessTrailsService());
  GetIt.instance.registerFactory(() => AccessTrailsViewmodel());

}
