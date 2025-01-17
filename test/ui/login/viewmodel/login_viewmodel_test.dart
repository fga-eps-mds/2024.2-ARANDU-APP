import 'package:aranduapp/ui/login/model/login_request.dart';
import 'package:aranduapp/ui/login/service/login_service.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalAuthentication>(), MockSpec<LoginService>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLocalAuthentication mockLocalAuthentication;
  late MockLoginService mockLoginService;
  late LoginViewModel loginViewModel;

  setUp(() async {
    loginViewModel = LoginViewModel();
    mockLocalAuthentication = MockLocalAuthentication();
    mockLoginService = MockLoginService();

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<LocalAuthentication>(
        () => mockLocalAuthentication);
    GetIt.I.registerLazySingleton<LoginService>(() => mockLoginService);
  });

  test('Should validate email and password and login successfully', () async {
    const String email = 'test@example.com';
    const String password = 'password123';

    var loginRequest = LoginRequest(email, password);

    when(mockLoginService.login(LoginRequest(email, password)))
        .thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
    });

    await loginViewModel.loginCommand.execute(loginRequest);

    expect(loginViewModel.loginCommand.isOk, isTrue);
    verify(mockLoginService.login(loginRequest)).called(1);
  });


  test('Should validate token successfully', () async {
    when(mockLoginService.validateToken())
        .thenAnswer((_) async => Result.value(null));

    await loginViewModel.validadeTokenCommand.execute();

    expect(loginViewModel.validadeTokenCommand.isOk, isTrue);
    verify(mockLoginService.validateToken()).called(1);
  });

  test('Should authenticate with biometrics if supported', () async {
    when(mockLocalAuthentication.canCheckBiometrics)
        .thenAnswer((_) async => true);
    when(mockLocalAuthentication.isDeviceSupported())
        .thenAnswer((_) async => true);
    when(mockLocalAuthentication.authenticate(
            localizedReason: anyNamed('localizedReason')))
        .thenAnswer((_) async => true);

    final result = await loginViewModel.loginWithDeviceAuth();

    expect(result, isTrue);
    verify(mockLocalAuthentication.authenticate(
            localizedReason: anyNamed('localizedReason')))
        .called(1);
  });

  test('Should return true if device authentication is not available',
      () async {
    when(mockLocalAuthentication.canCheckBiometrics)
        .thenAnswer((_) async => false);
    when(mockLocalAuthentication.isDeviceSupported())
        .thenAnswer((_) async => false);

    final result = await loginViewModel.loginWithDeviceAuth();

    expect(result, isTrue);
    verifyNever(mockLocalAuthentication.authenticate(
        localizedReason: anyNamed('localizedReason')));
  });
}
