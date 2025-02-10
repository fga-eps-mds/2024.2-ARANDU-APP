import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/core/network/studio_maker_api.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/model/subject_request.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SubjectService {
  Future<List<SubjectModel>> getSubjects(SubjectRequest SubjectRequest) async {
  Response response =
      await StudioMakerApi.getInstance().get(path: '/knowledges/${SubjectRequest.KnowledgeId}/subjects');

  Map<String, dynamic> knowledgeList = response.data as Map<String, dynamic>;

  List<dynamic> subjectList = knowledgeList["subjects"] ?? [];

  Log.i(subjectList);

  return subjectList.map((e) {
    final Map<String, dynamic> subjectMap = e as Map<String, dynamic>;

    return SubjectModel(
      id: subjectMap['_id'] ?? "Null",
      name: subjectMap['name'] ?? "Null",
      shortName: subjectMap['shortName'] ?? "Null",
      description: subjectMap['description'] ?? "Null",
    );
  }).toList();
}


  Future<bool> isUsersubscribe(String subjectId) async {

    String userId = (await GetIt.I<AuthRepository>().getUser()).id;

    Response response = await AuthApi.getInstance(auth: false)
        .get(path: '/users/$userId/subscribedSubjects');

    return response.toString().toLowerCase().contains(subjectId.toLowerCase());
  }
}
