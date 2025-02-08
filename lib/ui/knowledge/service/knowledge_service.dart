import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:dio/dio.dart';

class KnowledgeService {
  Future<List<Map<String, dynamic>>?> getKnowledges() async {
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

  Future<List<Map<String, dynamic>>?> getSubjectsByKnowledges(
      String knowledgeId, String name) async {
    try {
      String path = '/knowledges/$knowledgeId/subjects';
      Response response = await StudioMakerApi.getInstance().get(path: path);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final subjectsList = data['subjects'];
        return List<Map<String, dynamic>>.from(subjectsList);
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
