import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/subjects/model/subjects_request.dart';
//import 'package:aranduapp/ui/subjects/model/subjects_response.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class SubjectsViewmodel extends ChangeNotifier {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController pointIdController;

  List<SubjectsRequest> journeys = [];

  late Command0<List<SubjectsRequest>> journeyCommand;

  SubjectsViewmodel()
      : formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        descriptionController = TextEditingController(),
        pointIdController = TextEditingController() {
    journeyCommand = Command0(journey);

    journeyCommand.execute();
  }

  Future<Result<List<SubjectsRequest>>> journey() async {

    await Future.delayed(const Duration(seconds: 1));

    final journeyRequest = SubjectsRequest(
      title: "Viagem ao Parque",
      description: "Explorar o parque local com os amigos.",
    );

    return Result.value(List.generate(50, (_) => journeyRequest));
  }
}