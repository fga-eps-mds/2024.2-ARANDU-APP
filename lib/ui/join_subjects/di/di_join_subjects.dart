import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:aranduapp/ui/join_subjects/viewmodel/join_subjects_viewmodel.dart';
import 'package:get_it/get_it.dart';


void setupJoinSubjectsDI() {

  GetIt.instance.registerLazySingleton(() => JoinSubjectsService());
  GetIt.instance.registerFactory(() => JoinSubjectsViewmodel());
}

