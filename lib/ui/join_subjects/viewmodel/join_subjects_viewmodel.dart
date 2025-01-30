import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/join_subjects/model/join_subjects_model.dart';
import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JoinSubjectsViewmodel extends ChangeNotifier {

  late Command0<List<JoinSubjectsModel>> joinsubjectsCommand;

  JoinSubjectsViewmodel() {
    joinsubjectsCommand = Command0(joinsubjects);

    joinsubjectsCommand.execute();
  }

  Future<Result<List<JoinSubjectsModel>>> joinsubjects() async {

    final res = await GetIt.instance<JoinSubjectsService>().getJoinSubjects();

    return Result.value(res);
  }
}
