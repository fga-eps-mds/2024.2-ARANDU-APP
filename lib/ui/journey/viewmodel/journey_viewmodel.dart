import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/service/journey_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class JourneyViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController pointIdController;

  List<JourneyRequest> journeys = [];

  late Command0<void> journeyCommand;

  JourneyViewModel()
      : formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        descriptionController = TextEditingController(),
        pointIdController = TextEditingController() {
    journeyCommand = Command0(journey);
  }

  Future<Result<void>> journey() async {
    if (!formKey.currentState!.validate()) {
      return Result.error('Valores inválidos');
    }

    JourneyRequest request = JourneyRequest(
        title: titleController.text,
        description: descriptionController.text,
        pointId: pointIdController.text);

    await JourneyService.Future(request);

    return Result.value(null);
  }

 

 /* Future<void> loadJourneys() async {
    try {
      journeys = await JourneyService.fetchJourneys();
      notifyListeners();
    } catch (e) {
      // Trate o erro conforme necessário
    }
  } */
}
