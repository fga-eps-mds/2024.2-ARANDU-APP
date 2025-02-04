import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupSubjectDI() {
  GetIt.instance.registerLazySingleton(() => SubjectService());
  GetIt.instance.registerFactory(() => SubjectsViewmodel());
}
