import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/welcome/view/welcome_view.dart';

void main() {
  testWidgets('Welcome display screen', (WidgetTester tester) async {
    // Carrega o widget WelcomeView
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomeView(),
      ),
    );

    // Verifica se o texto "Arandú" está presente na tela
    expect(find.text('Arandú'), findsOneWidget);

    // Verifica se o botão "Começar" está presente
    expect(find.text('Começar'), findsOneWidget);

    // Verifica se o logo está sendo exibido (baseado no nome da imagem)
    expect(find.byType(Image), findsOneWidget);
  });
}
