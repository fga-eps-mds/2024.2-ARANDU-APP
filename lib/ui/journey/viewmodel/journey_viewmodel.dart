import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/journey/service/journey_service.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class JourneyViewModel extends ChangeNotifier {
  late Command1<List<JourneyModel>, String> getJourneyCommand;
  late Command1<void, String> subscribedJourneyCommand;

  bool _isReloadingData = false;

  JourneyViewModel() {
    getJourneyCommand = Command1(getJourney);

    subscribedJourneyCommand = Command1(subscribedJourney);
  }

  bool get isReloadingData => _isReloadingData;

  Future<Result<void>> subscribedJourney(String journeyId) async {
    await GetIt.instance<JourneyService>().subscribedJourney(journeyId);

    return Result.value(null);
  }

  Future<Result<List<JourneyModel>>> getJourney(String subjectId) async {
    _isReloadingData = true;
    notifyListeners();
    
    List<JourneyModel> res = await GetIt.instance<JourneyService>()
        .getJourneys(JourneyRequest(subjectId: subjectId));

    return Result.value(res);
  }
}
