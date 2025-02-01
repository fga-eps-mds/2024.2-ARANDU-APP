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
      final Map<String, dynamic> trailsMap = e as Map<String, dynamic>;

      final list = trailsMap['contents'] as List<dynamic>;

      return TrailsModel(
          id: trailsMap['_id']! as String,
          name: trailsMap['name']! as String,
          contectId: list.isNotEmpty ? list[0] as String : null,
          );
          
    }).toList();

    return res;
  }
}
