import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:dio/dio.dart';

class ContentService {
  Future<List<Map<String, dynamic>>?> getContentsByTrail(String trailId) async {
    try {
      String path = '/contents/trail/$trailId';
      Response response = await StudioMakerApi.getInstance().get(path: path);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        Log.e('Erro ao buscar conteúdos da trilha:${response.statusCode}');
        return null;
      }
    } catch (e) {
      Log.e('Erro na requisição $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getContentsById(String contentId) async {
    try {
      String path = '/contents/$contentId';
      Response response = await StudioMakerApi.getInstance().get(path: path);
      if (response.statusCode == 200 && response.data != null) {
        return Map<String, dynamic>.from(response.data);
      } else {
        Log.e('Erro ao buscar conteúdos da trilha:${response.statusCode}');
        return null;
      }
    } catch (e) {
      Log.e('Erro na requisição $e');
      return null;
    }
  }
}
