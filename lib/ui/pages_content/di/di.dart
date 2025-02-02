import 'package:aranduapp/ui/pages_content/viewmodel/page_content_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupPagesContentDI() {
  GetIt.I.registerFactory(() => PageContentViewmodel());
}
