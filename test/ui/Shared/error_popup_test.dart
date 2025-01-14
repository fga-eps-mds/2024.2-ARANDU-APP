import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/shared/error_popup.dart';

void main() {
  testWidgets('Testa ErrorPopUp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ErrorPopUp(
            content: Text('Este é um erro'),
          ),
        ),
      ),
    );

    // Verificar se o ícone de erro está presente
    expect(find.byIcon(Icons.error), findsOneWidget);

    // Verificar se o conteúdo do popup está correto
    expect(find.text('Este é um erro'), findsOneWidget);

    // Verificar se o botão 'OK' está presente
    expect(find.text('OK'), findsOneWidget);

    // Tocar no botão OK
    await tester.tap(find.text('OK'));

    // Rebuild após o tap para processar a navegação
    await tester.pumpAndSettle();

    expect(find.text('OK'), findsNothing);
    expect(find.byIcon(Icons.error), findsNothing);
    expect(find.text('Este é um erro'), findsNothing); // O popup desapareceu
  });
}
