import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/base_api.dart';
import 'package:aranduapp/ui/subjects/model/subjects_request.dart';
import 'package:aranduapp/ui/subjects/model/subjects_response.dart';
import 'package:dio/dio.dart';

class SubjectService {
  Future<List<SubjectsResponse>?> getSubjects(
      SubjectsRequest subjectRequest) async {
    Log.d(
        'Request Subject: ${subjectRequest.title}, ${subjectRequest.description}');

    Response response = await BaseApi.getInstance(auth: true)
        .get(path: '/subjects', data: subjectRequest.toJson());

    Log.d('Response Subject: ${response.toString()}');

    if (response.data != null) {
      List<dynamic> subjectList = response.data as List<dynamic>;
      return subjectList
          .map((subjectJson) => SubjectsResponse.fromJsonString(subjectJson))
          .toList();
    } else {
      Log.e('Não é uma lista');
      return null;
    }
  }
}
