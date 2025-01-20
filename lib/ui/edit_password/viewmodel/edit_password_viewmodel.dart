import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_password/model/edit_password_request.dart';
import 'package:aranduapp/ui/edit_password/service/edit_password_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditPasswordViewModel extends ChangeNotifier {
  late Command1<void, EditPasswordRequest> editCommand;

  EditPasswordViewModel() {
    editCommand = Command1<void, EditPasswordRequest>(editPassword);
  }

  Future<Result<void>> editPassword(EditPasswordRequest request) async {
    await GetIt.instance<EditPasswordService>().edit(request);
    return Result.value(null);
  }
}
