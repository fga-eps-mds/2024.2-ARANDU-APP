import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/model/subject_request.dart';
import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubjectsViewmodel extends ChangeNotifier {
  List<SubjectModel> subjects = [];

  late Command1<List<SubjectModel>, String> subjectCommand;
  late Command1<bool, String> isUserSUbscribedCommand;
  bool get isReloadingData => _isReloadingData;

  bool _isReloadingData = false;

  SubjectsViewmodel() {
    subjectCommand = Command1(getSubject);

    isUserSUbscribedCommand = Command1<bool, String>(_isUserSUbscribed);
  }

  Future<Result<List<SubjectModel>>> getSubject(String knowledgeId) async {
    List<SubjectModel> res = await GetIt.instance<SubjectService>()
        .getSubjects(SubjectRequest(KnowledgeId: knowledgeId));

    _isReloadingData = true;
    notifyListeners();
    return Result.value(res);
  }

  Future<Result<bool>> _isUserSUbscribed(String subjectId) async {
    var res = await GetIt.instance<SubjectService>().isUsersubscribe(subjectId);

    Log.i(res);

    return Result.value(res);
  }
}
