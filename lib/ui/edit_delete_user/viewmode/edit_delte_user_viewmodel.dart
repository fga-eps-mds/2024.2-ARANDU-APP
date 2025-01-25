import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_delete_user/service/edit_delete_user_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditDelteUserViewmodel extends ChangeNotifier {
  late Command0<void> deleteUserCommand;

  EditDelteUserViewmodel() {
    deleteUserCommand = Command0<void>(_deleteUser);
  }

  Future<Result<void>> _deleteUser() async {
    await GetIt.instance<EditDeleteUserService>()
        .deleteUser((await GetIt.instance<AuthRepository>().getUser()).id);

    await GetIt.instance<AuthRepository>().clearUser();

    return Result.value(null);
  }
}
