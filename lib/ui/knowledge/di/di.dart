import 'package:aranduapp/ui/knowledge/service/knowledge_service.dart';
import 'package:aranduapp/ui/knowledge/viewmodel/knowledge_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupknowledgeDI() {
  locator.registerLazySingleton(() => KnowledgeService());
  locator.registerFactory(() => KnowledgeViewmodel());
}
