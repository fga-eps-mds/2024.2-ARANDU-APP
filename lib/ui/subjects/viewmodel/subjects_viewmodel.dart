import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/subjects/model/subjects_request.dart';
import 'package:aranduapp/ui/subjects/model/subjects_response.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class SubjectsViewmodel extends ChangeNotifier {
  List<SubjectsResponse> subjects = [];

  late Command0<List<SubjectsRequest>> subjectCommand;

  SubjectsViewmodel() {
    subjectCommand = Command0(subject);

    subjectCommand.execute();
  }

  Future<Result<List<SubjectsRequest>>> subject() async {
    await Future.delayed(const Duration(seconds: 1));

    final subjectRequest = SubjectsRequest(
      title: "Viagem ao Parque",
      description: "Explorar o parque local com os amigos.",
    );

    return Result.value(List.generate(20, (_) => subjectRequest));
  }
}
