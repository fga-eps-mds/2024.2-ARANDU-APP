import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/login/model/login_request.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:aranduapp/ui/navbar/view/navbar_view.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/text_password.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(
    [MockSpec<LoginViewModel>(), MockSpec<Command0>(), MockSpec<Command1>()])
import 'login_view_test.mocks.dart';

void main() {
  late MockLoginViewModel mockViewModel;
  late MockCommand1<void, LoginRequest> mockLoginCommand;
  late MockCommand0 mockValidadeTokenCommand;

  setUp(() async {
    mockViewModel = MockLoginViewModel();

    mockLoginCommand = MockCommand1();

    when(mockLoginCommand.execute(any))
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
    expect(find.byType(CommandButton), findsOneWidget);
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

    await tester.tap(find.byKey(const Key('elevated_button_key')));

    verify(mockLoginCommand.execute(argThat(
      predicate<LoginRequest>(
          (req) => req.email == email && req.password == password),
    ))).called(1);
  });

  testWidgets('Login is successful', (WidgetTester tester) async {
    when(mockValidadeTokenCommand.isError).thenReturn(true);
    when(mockLoginCommand.execute(any))
        .thenAnswer((_) async => Result.value(null));

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    const email = 'test@example.com';
    const password = 'password123';

    await tester.enterText(find.byType(TextEmail), email);
    await tester.enterText(find.byType(TextPassWord), password);

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verify(mockLoginCommand.execute(argThat(
      predicate<LoginRequest>(
          (req) => req.email == email && req.password == password)
    ))).called(1);

    // TODO: Verify navigation to navbar
  });
  testWidgets('Displays error when login fails', (WidgetTester tester) async {
    //TODO:
  });
}
