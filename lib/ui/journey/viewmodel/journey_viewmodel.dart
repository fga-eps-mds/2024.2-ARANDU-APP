import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/model/journey_response.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class JourneyViewModel extends ChangeNotifier {
  List<JourneyResponse> journeys = [];

  late Command0<List<JourneyRequest>> journeyCommand;

  JourneyViewModel() {
    journeyCommand = Command0(journey);

    journeyCommand.execute();
  }

  Future<Result<List<JourneyRequest>>> journey() async {

    await Future.delayed(const Duration(seconds: 1));

    final journeyRequest = JourneyRequest(
      title: "Viagem ao Parque",
      description: "Explorar o parque local com os amigos.",
      pointId: "123",
    );

    return Result.value(List.generate(50, (_) => journeyRequest));
  }
}
