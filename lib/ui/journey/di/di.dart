import 'package:aranduapp/ui/journey/service/journey_service.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:get_it/get_it.dart';


void setupJourneyDI() {

  GetIt.instance.registerLazySingleton(() => JourneyService());
  GetIt.instance.registerFactory(() => JourneyViewModel());

}
