import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/join_subjects/model/join_subjects_model.dart';
import 'package:dio/dio.dart';

class JoinSubjectsService {
  Future<List<JoinSubjectsModel>> getJoinSubjects() async {
    Response response =
        await StudioMakerApi.getInstance().get(path: '');

    List<dynamic> subjectList = response.data as List<dynamic>;

    Log.i(subjectList);

    return subjectList.map((e) {
      final Map<String, dynamic> joinsubjectMap = e as Map<String, dynamic>;

      return JoinSubjectsModel(
          id: joinsubjectMap['_id']?? "Null",
          title: joinsubjectMap['title'] ?? "Null",
          description: joinsubjectMap['description'] ?? "Null");
    }).toList();
  }
}
