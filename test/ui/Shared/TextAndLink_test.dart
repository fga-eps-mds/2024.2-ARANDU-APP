import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/shared/TextAndLink.dart';

void main() {
  testWidgets('Testa o widget TextAndLink', (WidgetTester tester) async {
    // Flag para verificar se a ação foi acionada corretamente
    bool actionTriggered = false;

    // Função de callback para simular a ação quando o link é clicado
    void mockAction() {
      actionTriggered = true;
    }

    // Dados para exibição no widget
    const String text = "Não tem uma conta?";
    const String link = "Cadastre-se";

    // Constrói o widget dentro de um ambiente MaterialApp
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextAndLink(
            text: text,
            link: link,
            action: mockAction,
          ),
        ),
      ),
    );

    // Verifica se o texto principal e o link estão presentes na interface
    expect(find.text(text), findsOneWidget);
    expect(
        find.text(' $link'), findsOneWidget); // Inclui o espaço antes do link

    // Simula o clique no link
    final linkFinder =
        find.text(' $link'); // Localiza o texto do link com o espaço
    await tester.tap(linkFinder);
    await tester.pump();

    // Confirma que a função de ação foi chamada após o clique
    expect(actionTriggered, isTrue);
  });
}
