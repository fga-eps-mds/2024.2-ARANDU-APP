import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';

void main() {
  group('RegisterAccount Widget Tests', () {
    testWidgets('Verifica se os widgets básicos estão presentes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterAccount(),
        ),
      );
      // Verifica a presença dos itens.
      expect(find.byType(TitleSlogan), findsOneWidget);
      expect(find.byType(TextName), findsNWidgets(2));
      expect(find.byType(TextEmail), findsOneWidget);
      expect(find.byType(TextPassWord), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Interação com o formulário de registro',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterAccount(),
        ),
      );

      // Interações com os campos de texto
      await tester.enterText(
          find.widgetWithText(TextName, 'Nome'), 'Teste Nome');
      expect(find.text('Teste Nome'), findsOneWidget);

      await tester.enterText(
          find.widgetWithText(TextName, 'Nome de Usuário'), 'TesteUsuario');
      expect(find.text('TesteUsuario'), findsOneWidget);

      await tester.enterText(find.byType(TextEmail), 'teste@email.com');
      expect(find.text('teste@email.com'), findsOneWidget);

      await tester.enterText(find.byType(TextPassWord), '123456');
      expect(find.text('123456'), findsOneWidget);

      // Interação com o checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

      // Interações com o botão
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Teste do botão de login com o Google',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterAccount(),
        ),
      );

      // Interações com o botão do google
      final googleButton = find.byType(GestureDetector);
      expect(googleButton, findsOneWidget);

      await tester.tap(googleButton);
      await tester.pump();
    });
  });
}
