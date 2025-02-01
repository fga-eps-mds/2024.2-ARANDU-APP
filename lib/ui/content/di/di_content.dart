import 'package:aranduapp/core/di/locator.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupContentDI() {
  locator.registerLazySingleton(() => ContentService());
  GetIt.I.registerFactory(() => ContentViewModel());
}
