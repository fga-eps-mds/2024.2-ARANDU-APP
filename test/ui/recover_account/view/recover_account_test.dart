import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/shared/text_and_link.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/title_slogan.dart';
import 'package:aranduapp/ui/shared/request_button.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/recover_account/view/recover_account_view.dart';
import 'package:aranduapp/ui/recover_account/view_model/recover_account_view_model.dart';

@GenerateNiceMocks([MockSpec<RecoverAccountViewModel>(), MockSpec<Command0>()])
import 'recover_account_test.mocks.dart';

void main() {
  late MockRecoverAccountViewModel mockViewModel;
  late Command0 mockCommand0;

  setUp(() {
    mockViewModel = MockRecoverAccountViewModel();
    mockCommand0 = MockCommand0();

    when(mockCommand0.execute()).thenAnswer((_) async => Result.value(null));
    when(mockViewModel.recoverCommand).thenReturn(mockCommand0);

    when(mockViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockViewModel.emailController).thenReturn(TextEditingController());
  });

  Widget createLoginScreen(MockRecoverAccountViewModel mockViewModel) {
    return ChangeNotifierProvider<RecoverAccountViewModel>.value(
      value: mockViewModel,
      builder: (context, child) {
        return const MaterialApp(
          home: RecoverAccountScreen(),
        );
      },
    );
  }

  testWidgets('Register Account screen displays fields and send button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen(mockViewModel));
    await tester.pump();

    expect(find.byType(TitleSlogan), findsOneWidget);
    expect(find.byType(TextEmail), findsOneWidget);
    expect(find.byType(Requestbutton), findsOneWidget);
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
