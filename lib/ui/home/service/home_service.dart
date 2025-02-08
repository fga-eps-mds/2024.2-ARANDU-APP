import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/home/model/home_knowledge_request.dart';
import 'package:dio/dio.dart';

class HomeService {
  Future<List<Map<String, dynamic>>?> getKnowledges(
      HomeRequest homeRequest) async {
    try {
      String path = '/knowledges';
      Response response = await StudioMakerApi.getInstance().get(path: path);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        Log.e('Erro ao buscar áreas de conhecimento:${response.statusCode}');
        return null;
      }
    } catch (e) {
      Log.e('Erro na requisição $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getSubjects(
      String knowledgeId, String name) async {
    try {
      String path = '/knowledges/$knowledgeId';
      Response response = await StudioMakerApi.getInstance().get(path: path);
      if (response.statusCode == 200 && response.data != null) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        Log.e('Erro ao buscar as disciplinas de $name :${response.statusCode}');
        return null;
      }
    } catch (e) {
      Log.e('Erro na requisição $e');
      return null;
    }
  }
}
