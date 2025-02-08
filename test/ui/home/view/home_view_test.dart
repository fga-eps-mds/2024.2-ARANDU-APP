import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/knowledge/view/knowledge_view.dart';

void main() {
  testWidgets('Home screen displays', (WidgetTester tester) async {
    // Carrega o widget HomeView
    await tester.pumpWidget(
      const MaterialApp(
        home: KnowledgeView(),
      ),
    );

    // Verifica se o texto "Home" está presente na tela
    expect(find.text('Home'), findsOneWidget);
  });
}
