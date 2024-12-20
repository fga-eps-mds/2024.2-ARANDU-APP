import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/recover_account/view/recover_account_view.dart';
import 'package:aranduapp/ui/recover_account/viewModel/recover_account_view_model.dart';

@GenerateNiceMocks([MockSpec<RecoverAccountViewModel>()])
import 'recover_account_test.mocks.dart';

void main() {
  late MockRecoverAccountViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockRecoverAccountViewModel();
    when(mockViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockViewModel.emailController).thenReturn(TextEditingController());
    when(mockViewModel.isLoading).thenReturn(true);
  });

  testWidgets('Testa estado do botão enviar quando isLoading é verdadeiro',
      (WidgetTester tester) async {
    when(mockViewModel.isLoading).thenReturn(true);

    await tester.pumpWidget(
      ChangeNotifierProvider<RecoverAccountViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: RecoverAccountScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Enviar'), findsNothing);

  });

  testWidgets('Testa estado do botão enviar quando isLoading é falso',
      (WidgetTester tester) async {
    when(mockViewModel.isLoading).thenReturn(false);

    await tester.pumpWidget(
      ChangeNotifierProvider<RecoverAccountViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: RecoverAccountScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Enviar'), findsOneWidget);
  });
}
