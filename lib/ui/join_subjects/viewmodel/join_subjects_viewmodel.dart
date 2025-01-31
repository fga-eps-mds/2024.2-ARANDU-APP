import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JoinSubjectsViewmodel extends ChangeNotifier {
  late Command0<SubjectModel> joinsubjectsCommand;

  final bool _isSubscribe = false;
  SubjectModel? _subject;

  bool get isSubscribe => _isSubscribe;
  SubjectModel? get subject => _subject;

  JoinSubjectsViewmodel() {
    joinsubjectsCommand = Command0<SubjectModel>(joinsubjects);
  }

  Future<void> subjectDetails(String subjectId) async {
    _subject = await GetIt.instance<JoinSubjectsService>()
        .getJoinSubjects(subjectId);
    notifyListeners();
  }

  Future<Result<SubjectModel>> joinsubjects() async {
    if (_subject == null) {
      return Result.error('sem disciplina.');
    }
    return Result.value(_subject!);
  }
}
