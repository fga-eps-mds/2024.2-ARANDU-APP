import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubjectsViewmodel extends ChangeNotifier {
  List<SubjectModel> subjects = [];

  late Command0<List<SubjectModel>> subjectCommand;
  late Command1<bool, String> isUserSUbscribedCommand;

  bool _isReloadingData = false;

  SubjectsViewmodel() {
    subjectCommand = Command0(_subject);
    subjectCommand.execute();

    isUserSUbscribedCommand = Command1<bool, String>(_isUserSUbscribed);
  }

   bool get isReloadingData => _isReloadingData;

  Future<Result<List<SubjectModel>>> _subject() async {
    _isReloadingData = true;
    notifyListeners();

    final res = await GetIt.instance<SubjectService>().getSubjects();

    return Result.value(res);
  }

  Future<Result<bool>> _isUserSUbscribed(String subjectId) async {
    var res = await GetIt.instance<SubjectService>().isUsersubscribe(subjectId);

    Log.i(res);

    return Result.value(res);
  }
}
