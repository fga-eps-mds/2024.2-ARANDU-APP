import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/core/network/token_manager/repository/auth_repository.dart';
import 'package:aranduapp/core/network/token_manager/service/auth_service.dart';
import 'package:aranduapp/ui/edit_delete_user/service/edit_delete_user_service.dart';
import 'package:aranduapp/ui/edit_delete_user/viewmode/edit_delte_user_viewmodel.dart';
import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_delete_user_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>(), MockSpec<EditDeleteUserService>()])

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockEditDeleteUserService mockEditDeleteUserService;
  late MockAuthRepository mockAuthRepository;
  late EditDelteUserViewmodel editDelteUserViewmodel;

  final user = UserModel(id: '123456789', name: 'usertest', userName: 'usertest2', email: 'usertest@gmail.com', role: 'estudante');

  setUp(() async {
    editDelteUserViewmodel = EditDelteUserViewmodel();
    mockEditDeleteUserService = MockEditDeleteUserService();
    mockAuthRepository = MockAuthRepository(); // Criando mock

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<AuthRepository>(() => mockAuthRepository);
    GetIt.I.registerLazySingleton<EditDeleteUserService>(() => mockEditDeleteUserService);

  });

  test('delete user should return isOk if service return success', () async {

    when(mockAuthRepository.getUser()).thenAnswer((_) async => user);

    when(mockEditDeleteUserService.deleteUser(user.id))
        .thenAnswer((_) async => Result.value(null));

    await editDelteUserViewmodel.deleteUserCommand.execute();

    expect(editDelteUserViewmodel.deleteUserCommand.isOk, isTrue);
    verify(mockEditDeleteUserService.deleteUser(user.id)).called(1);
  });

  test('delete user should return error if service fails', () async{
    when(mockAuthRepository.getUser()).thenAnswer((_) async => user);

    when(mockEditDeleteUserService.deleteUser(user.id))
        .thenThrow(Exception('Failed to delete user'));

    await editDelteUserViewmodel.deleteUserCommand.execute();

    expect(editDelteUserViewmodel.deleteUserCommand.isError, isTrue);
    verify(mockEditDeleteUserService.deleteUser(user.id)).called(1);
  });
}