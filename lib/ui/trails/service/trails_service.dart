import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/trails/model/trails_model.dart';
import 'package:aranduapp/ui/trails/model/trails_request.dart';
import 'package:dio/dio.dart';

class TrailsService {
  Future<List<TrailsModel>> getTrails(TrailsRequest trailsRequest) async {
    Response response = await StudioMakerApi.getInstance()
        .get(path: '/trails/journey/${trailsRequest.journeyId}');

    List<dynamic> journeyList = response.data as List<dynamic>;

    Log.i(journeyList);

    var res = journeyList.map((e) {
      final Map<String, dynamic> journeyMap = e as Map<String, dynamic>;

      return TrailsModel(
          id: journeyMap['_id']! as String,
          name: journeyMap['name']! as String);
    }).toList();

    return res;
  }
}
