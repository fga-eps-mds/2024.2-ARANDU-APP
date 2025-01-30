import 'package:aranduapp/core/network/token_manager/di/di_auth.dart';
import 'package:aranduapp/ui/edit_delete_user/di/di_edit_delete_user.dart';
import 'package:aranduapp/ui/edit_password/di/di_edit_password.dart';
import 'package:aranduapp/ui/edit_profile/di/di_edit_profile.dart';
import 'package:aranduapp/ui/journey/di/di.dart';
import 'package:aranduapp/ui/login/di/di_login.dart';
import 'package:aranduapp/ui/navbar/di/di_navbar.dart';
import 'package:aranduapp/ui/onboarding/di/di_onboarding.dart';
import 'package:aranduapp/ui/profile/di/di_profile.dart';
import 'package:aranduapp/ui/recover_account/di/di_recover_account.dart';
import 'package:aranduapp/ui/register_account/di/di_register_account.dart';
import 'package:aranduapp/ui/join_subjects/di/di_join_subjects.dart';
import 'package:aranduapp/ui/subjects/di/di.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  setupLoginDI();
  setupRegisterDI();
  setupEditProfileDI();
  setupRecoverAccountDI();
  setupEditPasswordDI();
  setupNavBarDI();
  setupOnboardingDI();
  setupJourneyDI();
  setupSubjectDI();
  setupProfileDI();
  setupAuthDI();
  setupEditDeleteUser();
  setupJoinSubjectsDI();
}
