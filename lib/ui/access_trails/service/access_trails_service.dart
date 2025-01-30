import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
import 'package:dio/dio.dart';

class AccessTrailsService {
  Future<List<AccessTrailsModel>> getTrails() async {
    try {
      Response response = await StudioMakerApi.getInstance().get(path: '/trails');
      List<dynamic> trailsList = response.data as List<dynamic>;

      Log.i(trailsList);

      return trailsList.map((e) {
        final Map<String, dynamic> trailsMap = e as Map<String, dynamic>;

        return AccessTrailsModel(
          id: trailsMap['_id'] ?? "Null",
          title: trailsMap['name'] ?? "Null",
          description: trailsMap['description'] ?? "Null",
        );
      }).toList();
    } catch (e) {
      Log.e("Error fetching trails: $e");
      rethrow;
    }
  }
}
