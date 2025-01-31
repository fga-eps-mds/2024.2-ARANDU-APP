import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:dio/dio.dart';

class SubjectService {
  Future<List<SubjectModel>> getSubjects() async {
    Response response =
        await StudioMakerApi.getInstance().get(path: '/subjects');

    List<dynamic> subjectList = response.data as List<dynamic>;

    Log.i(subjectList);

    return subjectList.map((e) {
      final Map<String, dynamic> subjectMap = e as Map<String, dynamic>;

      return SubjectModel(
          id: subjectMap['_id'] ?? "Null",
          name: subjectMap['name'] ?? "Null",
          shortName: subjectMap['shortName'] ?? "Null",
          description: subjectMap['description'] ?? "Null");
    }).toList();
  }

  Future<bool> isUsersubscribe(String subjectId) async {
    String userId = (await AuthRepository().getUser()).id;

    try {
      Response response = await StudioMakerApi.getInstance()
          .get(path: '/users/$userId/subscribedSubjects');

      Log.d(response);

      return response.data['isSubscribe'] ?? false;
    } catch (e) {
      Log.d('Erro ao verificar inscrição: $e');
      return false;
    }
  }
}
