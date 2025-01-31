import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubjectsViewmodel extends ChangeNotifier {
  List<SubjectModel> subjects = [];

  late Command0<List<SubjectModel>> subjectCommand;
  late Command1<bool, String> isUserSUbscribedCommand;

  SubjectsViewmodel() {
    subjectCommand = Command0(subject);
    subjectCommand.execute();

    isUserSUbscribedCommand =  Command1<bool, String> (isUserSUbscribed);
  }

  Future<Result<List<SubjectModel>>> subject() async {
    final res = await GetIt.instance<SubjectService>().getSubjects();

    return Result.value(res);
  }
 Future<Result<bool>> isUserSUbscribed(String subjectId) async {
    return Result.value( await GetIt.instance<JoinSubjectsService>()
        .isUsersubscribe(subjectId));

  }
}
