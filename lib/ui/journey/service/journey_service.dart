import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/model/journey_response.dart';
import 'package:dio/dio.dart';

class JourneyService {
   Future<List<JourneyResponse>?> getJourneys(JourneyRequest journeyRequest) async {
    Log.d('Request Journey: ${journeyRequest.title}, ${journeyRequest.description}, ${journeyRequest.pointId}');

    Response response = await BaseApi.getInstance(auth: true)
        .get(path: '/journeys', data: journeyRequest.toJson());

    Log.d('Response Journey: ${response.toString()}');

    if (response.data != null) {
      List<dynamic> journeyList = response.data as List<dynamic>;
      return journeyList
          .map((journeyJson) => JourneyResponse.fromJsonString(journeyJson))
          .toList();
    } else {
      Log.e('Não é uma lista');
      return null;
    }
    
  }
}
