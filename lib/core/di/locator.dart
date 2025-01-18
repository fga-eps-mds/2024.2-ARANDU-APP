import 'package:aranduapp/ui/edit_password/di/di.dart';
import 'package:aranduapp/ui/edit_profile/di/di.dart';
import 'package:aranduapp/ui/login/di/di.dart';
import 'package:aranduapp/ui/register_account/di/di.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  setupLoginDI();
  setupRegisterDI();
  setupEditProfileDI();
  setupPasswordDI();
}
