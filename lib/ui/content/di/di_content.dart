import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupContentDI() {
  GetIt.I.registerFactory(() => ContentViewModel());
}
