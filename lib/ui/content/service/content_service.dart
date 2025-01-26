import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:aranduapp/ui/content/model/content_response.dart';
import 'package:dio/dio.dart';

class ContentService {
  Future<List<ContentResponse>?> getContents(
      ContentRequest contentRequest) async {
    Log.d(
        'Request Content: ${contentRequest.title}, ${contentRequest.content}, ${contentRequest.trailID}');

    Response response = await BaseApi.getInstance(auth: true)
        .get(path: '/contents/trail/{id}', data: contentRequest.toJson());

    Log.d('Response Content: ${response.toString()}');

    if (response.data != null) {
      List<dynamic> contentList = response.data as List<dynamic>;
      return contentList
          .map((contentJson) => ContentResponse.fromJsonString(contentJson))
          .toList();
    } else {
      Log.e('Não é um conteúdo');
      return null;
    }
  }
}
