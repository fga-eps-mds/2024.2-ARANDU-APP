import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/register_account/model/register_request.dart';
import 'package:aranduapp/ui/register_account/view/register_account_view.dart';
import 'package:aranduapp/ui/shared/error_popup.dart';
import 'package:aranduapp/ui/shared/text_and_link.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/text_password.dart';
import 'package:aranduapp/ui/shared/title_slogan.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<RegisterAccountViewModel>(), MockSpec<Command1>()])
import 'package:aranduapp/ui/register_account/viewmodel/register_viewmodel.dart';

import 'register_account_view_test.mocks.dart';

void main() {
  late MockRegisterAccountViewModel mockViewModel;
  late MockCommand1<void, RegisterRequest> mockRegisterCommand1;

  setUp(() async {
    mockViewModel = MockRegisterAccountViewModel();
    mockRegisterCommand1 = MockCommand1();

    when(mockViewModel.registerCommand).thenReturn(mockRegisterCommand1);

    when(mockRegisterCommand1.execute(any)).thenAnswer(
      (_) async => Result.value(null),
    );

    when(mockRegisterCommand1.isOk).thenReturn(false);
    when(mockRegisterCommand1.isError).thenReturn(false);
    when(mockRegisterCommand1.running).thenReturn(false);

    when(mockViewModel.isTermsAccepted).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I
        .registerLazySingleton<RegisterAccountViewModel>(() => mockViewModel);
  });

  Widget createLoginScreen() {
    return const MaterialApp(
      home: RegisterAccount(),
    );
  }

  testWidgets('Register Account screen displays fields and send button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());
    await tester.pump();

    expect(find.byType(TitleSlogan), findsOneWidget);
    expect(find.byKey(const Key('nameField')), findsOneWidget);
    expect(find.byKey(const Key('userNameField')), findsOneWidget);
    expect(find.byType(TextEmail), findsOneWidget);
    expect(find.byType(TextPassWord), findsOneWidget);

    expect(find.text('Registrar'), findsOneWidget);
    expect(find.byType(TextAndLink), findsOneWidget);
  });

  testWidgets('Register Account Test User Input', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    const name = 'gabriel';
    const email = 'gabriel.costa513@gmail.com';
    const userName = 'gabrile';
    const password = '123456789';

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('nameField')), name);
    await tester.enterText(find.byKey(const Key('userNameField')), userName);
    await tester.enterText(find.byType(TextEmail), email);
    await tester.enterText(find.byType(TextPassWord), password);


    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    await tester.pumpAndSettle();

    verify(mockRegisterCommand1.execute(argThat(predicate<RegisterRequest>(
        (req) =>
            req.name == name &&
            req.email == email &&
            req.userName == userName &&
            req.password == password)))).called(1);
  });

  testWidgets('Register Account user notification snackbar',
      (WidgetTester tester) async {
    when(mockRegisterCommand1.isOk).thenReturn(true);

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Register Account user notification popup error',
      (WidgetTester tester) async {
    when(mockViewModel.registerCommand).thenReturn(mockRegisterCommand1);
    when(mockRegisterCommand1.isError).thenReturn(true);

    const error = 'error message.';

    when(mockRegisterCommand1.result).thenReturn(Result.error(error));

    await tester.pumpWidget(createLoginScreen());
    await tester.pumpAndSettle();

    expect(find.byType(ErrorPopUp), findsOneWidget);
    expect(find.text(error), findsOneWidget);
  });
}
