import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_request.dart';
import 'package:dio/dio.dart';

class AccessTrailsService {
  Future<List<AccessTrailsModel>> getTrails(AccessTrailsRequest AccessTrailsRequest) async {
    Response response = await StudioMakerApi.getInstance()
        .get(path: '/journeys/subjects/${AccessTrailsRequest.JourneyId}');

    List<dynamic> JourneyList = response.data as List<dynamic>;

    Log.i(JourneyList);

    var res = JourneyList.map((e) {
      final Map<String, dynamic> JourneyMap = e as Map<String, dynamic>;

      return AccessTrailsModel(
          id: JourneyMap['_id']! as String,
          title: JourneyMap['title']! as String,
          description: JourneyMap['description']! as String);
    }).toList();

    return res;
  }
}
