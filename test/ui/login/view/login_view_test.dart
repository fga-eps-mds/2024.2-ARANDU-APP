import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewModel/login_view_model.dart';
import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

@GenerateNiceMocks([MockSpec<LoginViewModel>()])
import 'login_view_test.mocks.dart';

void main() {
  late MockLoginViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockLoginViewModel();
    when(mockViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockViewModel.emailController).thenReturn(TextEditingController());
    when(mockViewModel.passwordController).thenReturn(TextEditingController());
  });

  Widget createLoginScreen(LoginViewModel mockViewModel) {
    return ChangeNotifierProvider<LoginViewModel>.value(
      value: mockViewModel,
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  testWidgets('Displays loading screen while waiting for Future',
      (WidgetTester tester) async {
    when(mockViewModel.validateToken()).thenAnswer(
        (_) async => await Future.delayed(const Duration(seconds: 1)));

    await tester.pumpWidget(createLoginScreen(mockViewModel));

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('login with auth device', (WidgetTester tester) async {
    when(mockViewModel.loginWithDeviceAuth()).thenAnswer((_) async => false);

    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pumpAndSettle();

    when(mockViewModel.loginWithDeviceAuth()).thenAnswer((_) async => true);
    final button = find.text('Usar senha do celular');
    expect(button, findsOneWidget);
    await tester.tap(button);

    await tester.pumpAndSettle();

    verify(mockViewModel.goToHome()).called(1);
    verify(mockViewModel.loginWithDeviceAuth()).called(2);
  });

  testWidgets(
      'Login screen displays email and password fields and login button',
      (WidgetTester tester) async {
    when(mockViewModel.validateToken())
        .thenAnswer((_) async => throw Exception('Token validation failed'));

    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pumpAndSettle();

    expect(find.byType(TextEmail), findsOneWidget);
    expect(find.byType(TextPassWord), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Test User Input for Email and Password',
      (WidgetTester tester) async {
    when(mockViewModel.validateToken())
        .thenAnswer((_) async => throw Exception('Token validation failed'));

    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pumpAndSettle();

    const email = 'test@example.com';
    const password = 'password123';

    await tester.enterText(find.byType(TextEmail), email);
    await tester.enterText(find.byType(TextPassWord), password);

    expect(mockViewModel.emailController.text, email);
    expect(mockViewModel.passwordController.text, password);
  });

  testWidgets('Login is successful',
      (WidgetTester tester) async {
    when(mockViewModel.validateToken())
        .thenAnswer((_) async => throw Exception('Token validation failed'));

    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));

    when(mockViewModel.loginWithEmailAndPassword()).thenAnswer(
        (_) async => await Future.delayed(const Duration(seconds: 1)));

    await tester.pumpAndSettle();
    verify(mockViewModel.loginWithEmailAndPassword()).called(1);
    verify(mockViewModel.goToHome()).called(1);
  });

  testWidgets('Displays error when login fails', (WidgetTester tester) async {
  });
}
