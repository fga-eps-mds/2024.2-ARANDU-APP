import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/model/journey_response.dart';
import 'package:aranduapp/ui/journey/service/journey_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JourneyViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController pointIdController;

  List<JourneyResponse> journeys = [];

  late Command0<List<JourneyRequest>> journeyCommand;

  JourneyViewModel()
      : formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        descriptionController = TextEditingController(),
        pointIdController = TextEditingController() {
    journeyCommand = Command0(journey);



    journeyCommand.execute();
  }

  Future<Result<List<JourneyRequest>>> journey() async {
//  if (!formKey.currentState!.validate()) {
//    return Result.error('Valores inválidos');
//  }

//  JourneyRequest request = JourneyRequest(
//      title: titleController.text,
//      description: descriptionController.text,
//      pointId: pointIdController.text);

//  List<JourneyResponse>? journeysResponse =
//      await GetIt.instance<JourneyService>().getJourneys(request);

//  if (journeysResponse != null) {
//    journeys = journeysResponse;
//    notifyListeners();
//    return Result.value(null);
//  }
//    return Result.error('nenhuma jornada encontrada');

    await Future.delayed(const Duration(seconds: 1));

    final journeyRequest = JourneyRequest(
      title: "Viagem ao Parque",
      description: "Explorar o parque local com os amigos.",
      pointId: "123",
    );

    return Result.value(List.generate(50, (_) => journeyRequest));
  }
}