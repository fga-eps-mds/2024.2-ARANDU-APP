import 'package:aranduapp/ui/recover_account/service/recover_account_service.dart';
import 'package:aranduapp/ui/recover_account/viewmodel/recover_account_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupRecoverAccountDI() {
  GetIt.I.registerLazySingleton(() => RecoverAccountService());

  GetIt.I.registerFactory(() => RecoverAccountViewModel());
}
