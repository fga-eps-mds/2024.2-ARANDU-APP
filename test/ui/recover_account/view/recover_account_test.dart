import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/shared/text_and_link.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/title_slogan.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:aranduapp/ui/recover_account/viewmodel/recover_account_viewmodel.dart';

@GenerateNiceMocks([MockSpec<RecoverAccountViewModel>(), MockSpec<Command0>()])
import 'recover_account_test.mocks.dart';

void main() {
  late MockRecoverAccountViewModel mockViewModel;
  late Command0 mockCommand0;

  setUp(() async {
    mockViewModel = MockRecoverAccountViewModel();
    mockCommand0 = MockCommand0();

    when(mockCommand0.execute()).thenAnswer((_) async => Result.value(null));
    when(mockViewModel.recoverCommand).thenReturn(mockCommand0);

    when(mockViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockViewModel.emailController).thenReturn(TextEditingController());

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<RecoverAccountViewModel>(() => mockViewModel);
  });

  Widget createLoginScreen(MockRecoverAccountViewModel mockViewModel) {
    return const MaterialApp(
      home: Login(),
    );
  }

  testWidgets('Register Account screen displays fields and send button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pump();

    expect(find.byType(TitleSlogan), findsOneWidget);
    expect(find.byType(TextEmail), findsOneWidget);
    expect(find.byType(CommandButton), findsOneWidget);
    expect(find.byType(TextAndLink), findsOneWidget);
  });

  testWidgets('Recover account sending request', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen(mockViewModel));

    final sendButton = find.text('Enviar');

    await tester.tap(sendButton);
    await tester.pump();

    verify(mockCommand0.execute()).called(1);
  });

  testWidgets('Recover account user input', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen(mockViewModel));

    const email = 'test@example.com';

    await tester.enterText(find.byType(TextEmail), email);
    await tester.pumpAndSettle();

    expect(mockViewModel.emailController.text, email);
  });
}
