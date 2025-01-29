import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubjectsViewmodel extends ChangeNotifier {
  List<SubjectModel> subjects = [];

  late Command0<List<SubjectModel>> subjectCommand;
  bool _isReloadingData = false;

  SubjectsViewmodel() {
    subjectCommand = Command0(subject);

    subjectCommand.execute();
  }

  bool get isReloadingData => _isReloadingData;

  Future<Result<List<SubjectModel>>> subject() async {
    _isReloadingData = true;
    notifyListeners();

  
    final res = await GetIt.instance<SubjectService>().getSubjects();

    return Result.value(res);
  } 
}
