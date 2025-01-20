import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/edit_password/model/edit_password_request.dart';
import 'package:aranduapp/ui/edit_password/view/edit_password_view.dart';
import 'package:aranduapp/ui/edit_password/viewmodel/edit_password_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_password_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EditPasswordViewModel>(), MockSpec<Command1>()])
void main() {
  late MockEditPasswordViewModel mockEditPasswordViewModel;
  late MockCommand1<void, EditPasswordRequest> mockEditPasswordCommand1;

  setUp(() async {
    mockEditPasswordViewModel = MockEditPasswordViewModel();

    mockEditPasswordCommand1 = MockCommand1();

    when(mockEditPasswordViewModel.editCommand)
        .thenReturn(mockEditPasswordCommand1);

    when(mockEditPasswordCommand1.running).thenReturn(false);
    when(mockEditPasswordCommand1.isError).thenReturn(false);
    when(mockEditPasswordCommand1.isOk).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<EditPasswordViewModel>(
        () => mockEditPasswordViewModel);
  });

  Widget createScreen() {
    return const MaterialApp(
      home: EditPassword(),
    );
  }

  testWidgets('edit password screen displays', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byKey(const ValueKey('old_password')), findsOneWidget);
    expect(find.byKey(const ValueKey('new_password')), findsOneWidget);
    expect(find.byType(CommandButton), findsOneWidget);
  });

  testWidgets('edit password right values', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    const oldPassword = 'test@example.com';
    const newPassword = 'password123';

    await tester.enterText(find.byKey(const Key('old_password')), oldPassword);
    await tester.enterText(find.byKey(const Key('new_password')), newPassword);

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verify(mockEditPasswordCommand1.execute(argThat(
        predicate<EditPasswordRequest>((req) =>
            req.oldPassword == oldPassword &&
            req.newPassword == newPassword)))).called(1);
  });

  testWidgets('edit password wrong values', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    const oldPassword = 'test';
    const newPassword = 'password123';

    await tester.enterText(find.byKey(const Key('old_password')), oldPassword);
    await tester.enterText(find.byKey(const Key('new_password')), newPassword);

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verifyNever(mockEditPasswordCommand1.execute(argThat(isNotNull)));
  });
}
