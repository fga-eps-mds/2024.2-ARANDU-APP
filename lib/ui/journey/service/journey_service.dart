import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:dio/dio.dart';

class JourneyService {
  Future<List<JourneyModel>> getJourneys(JourneyRequest journeyRequest) async {
    Response response = await StudioMakerApi.getInstance()
        .get(path: '/journeys/subjects/${journeyRequest.subjectId}');

    List<dynamic> subjectList = response.data as List<dynamic>;

    Log.i(subjectList);

    var res = subjectList.map((e) {
      final Map<String, dynamic> subjectMap = e as Map<String, dynamic>;

      return JourneyModel(
          id: subjectMap['_id']! as String,
          title: subjectMap['title']! as String,
          description: subjectMap['description'] as String?);
    }).toList();

    return res;
  }

  Future<void> subscribedJourney(String journeyId) async {
    var userId = (await AuthRepository().getUser()).id;

    await AuthApi.getInstance(auth: true).post(path:'/users/$userId/subscribe/$journeyId');


  }
}
