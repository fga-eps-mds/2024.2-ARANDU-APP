import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/shared/OrDivider.dart';

void main() {
  testWidgets('Testa se o componente OrDivider é renderizado corretamente',
      (WidgetTester tester) async {
    // Monta o widget para teste
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: OrDivider(),
      ),
    ));

    // Verifica se o widget contém dois Dividers
    expect(find.byType(Divider), findsNWidgets(2));

    // Verifica se o texto "ou" está presente
    expect(find.text('ou'), findsOneWidget);
  });
}
