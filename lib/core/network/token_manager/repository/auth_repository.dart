import 'package:aranduapp/core/data/local/storage_value.dart';
import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/core/network/token_manager/service/auth_service.dart';
import 'package:get_it/get_it.dart';

class AuthRepository {
  UserModel? _userCache;

  Future<UserModel> getUser() async {
    if (_userCache != null) {
      return _userCache!;
    } else {
      try {
        UserModel user = await GetIt.instance<AuthService>().getUser();
        _userCache = user;
        return user;
      } catch (e) {
        throw Exception('Erro ao obter o usuário');
      }
    }
  }

  Future<void> clearUser() async {
    _userCache = null;
    StorageValue.getInstance().setJsonUser(null);
  }
}
