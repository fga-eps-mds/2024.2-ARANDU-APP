import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewModel/login_view_model.dart';
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
  });

  testWidgets('Displays loading screen while waiting for Future',
      (WidgetTester tester) async {
    when(mockViewModel.validateToken()).thenAnswer(
        (_) async => await Future.delayed(const Duration(seconds: 1)));

    await tester.pumpWidget(
      ChangeNotifierProvider<LoginViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });


  testWidgets('login with auth device', (WidgetTester tester) async {
    when(mockViewModel.loginWithDeviceAuth()).thenAnswer((_) async => false);

    await tester.pumpWidget(
      ChangeNotifierProvider<LoginViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    when(mockViewModel.loginWithDeviceAuth()).thenAnswer((_) async => true);
    final button = find.text('Usar senha do celular');
    expect(button, findsOneWidget);
    await tester.tap(button);

    await tester.pumpAndSettle();

    verify(mockViewModel.goToHome()).called(1);
    verify(mockViewModel.loginWithDeviceAuth()).called(2);
  });
}
