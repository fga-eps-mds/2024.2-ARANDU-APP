import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:dio/dio.dart';

class JoinSubjectsService {
  Future<bool> isUsersubscribe(String subjectId) async {
    try {
      Response response = await StudioMakerApi.getInstance().get(
          path: '/users/{userId}/subscribedSubjects',
          queryParameters: {'subjectId': subjectId});
      return response.data['isSubscribe'] ?? false;
    } catch (e) {
      Log.d('Erro ao verificar inscrição: $e');
      return false;
    }
  }

  Future<SubjectModel> getJoinSubjects(String subjectId) async {
    try {
      Response response =
          await StudioMakerApi.getInstance().get(path: '/subjects/$subjectId',
          queryParameters: {},);

      return SubjectModel.fromJson(response.data);
    } catch (e) {
      Log.d('falha detalhes da disciplina');
      throw Exception('falha ao carregar');
    }
  }
}
