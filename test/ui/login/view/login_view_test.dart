import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:aranduapp/ui/navbar/view/navBarView.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LoginViewModel>(), MockSpec<Command0>()])
import 'login_view_test.mocks.dart';

void main() {
  late MockLoginViewModel mockViewModel;
  late MockCommand0 mockLoginCommand;
  late MockCommand0 mockValidadeTokenCommand;

  setUp(() async {
    mockViewModel = MockLoginViewModel();
    when(mockViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockViewModel.emailController).thenReturn(TextEditingController());
    when(mockViewModel.passwordController).thenReturn(TextEditingController());

    mockLoginCommand = MockCommand0();
    when(mockLoginCommand.execute())
        .thenAnswer((_) async => Result.value(null));
    when(mockViewModel.loginCommand).thenReturn(mockLoginCommand);

    mockValidadeTokenCommand = MockCommand0();
    when(mockViewModel.validadeTokenCommand)
        .thenReturn(mockValidadeTokenCommand);
    when(mockValidadeTokenCommand.execute())
        .thenAnswer((_) async => Result.value(null));
    when(mockValidadeTokenCommand.running).thenReturn(false);
    when(mockValidadeTokenCommand.isError).thenReturn(false);
    when(mockValidadeTokenCommand.isOk).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<LoginViewModel>(() => mockViewModel);
  });

  Widget createLoginScreen() {
    return const MaterialApp(
      home: Login(),
    );
  }

  testWidgets('Displays loading screen while waiting for validade token',
      (WidgetTester tester) async {
    when(mockValidadeTokenCommand.running).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('login with auth device', (WidgetTester tester) async {
    when(mockValidadeTokenCommand.isOk).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    when(mockViewModel.loginWithDeviceAuth()).thenAnswer((_) async => true);
    final button = find.text('Usar senha do celular');
    expect(button, findsOneWidget);
    await tester.tap(button);

    await tester.pumpAndSettle();

    expect(find.byType(NavbarView), findsOneWidget);

    verify(mockViewModel.loginWithDeviceAuth()).called(2);
  });

  testWidgets(
      'Login screen displays email and password fields and login button',
      (WidgetTester tester) async {
    when(mockValidadeTokenCommand.isError).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    expect(find.byType(TextEmail), findsOneWidget);
    expect(find.byType(TextPassWord), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Test User Input for Email and Password',
      (WidgetTester tester) async {
    when(mockValidadeTokenCommand.isError).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    const email = 'test@example.com';
    const password = 'password123';

    await tester.enterText(find.byType(TextEmail), email);
    await tester.enterText(find.byType(TextPassWord), password);

    expect(mockViewModel.emailController.text, email);
    expect(mockViewModel.passwordController.text, password);
  });

  testWidgets('Login is successful', (WidgetTester tester) async {
    when(mockValidadeTokenCommand.isError).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    when(mockLoginCommand.execute())
        .thenAnswer((_) async => Result.value(null));

    await tester.tap(find.text('Entrar'));

    await tester.pumpAndSettle();

    verify(mockLoginCommand.execute()).called(1);

    //TODO: verify navigation to navbar
  });

  testWidgets('Displays error when login fails', (WidgetTester tester) async {
    //TODO:
  });
}
