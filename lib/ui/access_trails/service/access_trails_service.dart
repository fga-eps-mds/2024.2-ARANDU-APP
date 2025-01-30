import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_request.dart';
import 'package:dio/dio.dart';

class AccessTrailsService {
  Future<List<AccessTrailsModel>> getAccessTrails(AccessTrailsRequest accessTrailsRequest) async {
    Response response = await StudioMakerApi.getInstance()
        .get(path: '/journeys/subjects/${accessTrailsRequest.journeyId}');

    List<dynamic> journeyList = response.data as List<dynamic>;

    Log.i(journeyList);

    var res = journeyList.map((e) {
      final Map<String, dynamic> journeyMap = e as Map<String, dynamic>;

      return AccessTrailsModel(
          id: journeyMap['_id'] as String? ?? "",
          title: journeyMap['title'] as String? ?? "Sem título",
          description: journeyMap['description'] as String? ?? "Sem descrição");
    }).toList();

    return res;
  }
}
