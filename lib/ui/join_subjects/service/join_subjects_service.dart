import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:dio/dio.dart';

class JoinSubjectsService {
  Future<bool> isUsersubscribe(String subjectId) async {
    try {
      Response response = await StudioMakerApi.getInstance().get(
          path: '/users/{userId}/subscribedSubjects');
      return response.data['isSubscribe'] ?? false;
    } catch (e) {
      Log.d('Erro ao verificar inscrição: $e');
      return false;
    }
  }

  Future<SubjectModel> getJoinSubjects(String subjectId) async {
      Response response =
          await StudioMakerApi.getInstance().get(path:'/subjects/$subjectId');

      return SubjectModel.fromJson(response.data);
  }
}
