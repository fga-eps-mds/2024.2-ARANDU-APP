import 'package:aranduapp/ui/navbar/viewmodel/navbar_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupNavBarDI() {
  GetIt.I.registerFactory(() => NavbarViewModel());
}
