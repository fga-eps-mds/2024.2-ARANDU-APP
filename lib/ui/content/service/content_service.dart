import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:aranduapp/ui/content/model/content_response.dart';
import 'package:async/async.dart';
// ignore: unused_import
import 'package:dio/dio.dart';

class ContentService {
  // Método para buscar um conteúdo pelo ID, retornando um Result<ContentRequest>
  Future<Result<ContentRequest>> getContentsById(String contentId) async {
    try {
      final path = '/contents/$contentId';
      final response = await StudioMakerApi.getInstance().get(path: path);

      if (response.statusCode == 200 && response.data != null) {
        final content = ContentRequest.fromMap(response.data);
        return Result.value(content); // Retorna um Result.value
      } else {
        return Result.error(
            Exception("Erro ao buscar conteúdo: ${response.statusCode}"));
      }
    } catch (e) {
      return Result.error(e); // Retorna um Result.error
    }
  }

  // Método para buscar conteúdos por trilha, retornando uma lista de ContentResponse
  Future<List<ContentResponse>?> getContentsByTrail(String trailID) async {
    try {
      final path = '/contents/trail/$trailID';
      final response = await StudioMakerApi.getInstance().get(path: path);

      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((item) => ContentResponse.fromJson(item))
            .toList();
      } else {
        Log.e('Erro ao buscar conteúdos: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Log.e('Erro na requisição: $e');
      return null;
    }
  }
}
