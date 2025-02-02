import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

class JoinSubjectsService {
  Future<void> joinSubjects(String subjectId) async {

    //TODO: isso está errado
    String userId = (await GetIt.I<AuthRepository>().getUser()).id;

    await AuthApi.getInstance(auth: true)
        .post(path: '/users/$userId/subjects/subscribe/$subjectId');

    return;
  }
}
