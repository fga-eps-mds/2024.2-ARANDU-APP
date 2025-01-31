import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:dio/dio.dart';

class SubjectService {
  Future<List<SubjectModel>> getSubjects() async {
    Response response =
        await StudioMakerApi.getInstance().get(path: '/subjects', 
        queryParameters: {});

    List<dynamic> subjectList = response.data as List<dynamic>;

    Log.i(subjectList);

    return subjectList.map((e) {
      final Map<String, dynamic> subjectMap = e as Map<String, dynamic>;

      return SubjectModel(
          id: subjectMap['_id']?? "Null",
          name: subjectMap['name'] ?? "Null",
          shortName: subjectMap['shortName']?? "Null",
          description: subjectMap['description'] ?? "Null");
    }).toList();
  }
}
