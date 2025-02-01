import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JoinSubjectsViewmodel extends ChangeNotifier {
  late Command1<void, String> joinsubjectsCommand;

  JoinSubjectsViewmodel() {
    joinsubjectsCommand = Command1(joinsubjects);
  }

  Future<Result<void>> joinsubjects(String subjectId) async {
    await GetIt.instance<JoinSubjectsService>().joinSubjects(subjectId);
    return Result.value(null);
  }
}
