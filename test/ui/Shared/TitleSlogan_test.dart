import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aranduapp/ui/shared/TitleSlogan.dart';

void main() {
  testWidgets('Testa TitleSlogan', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TitleSlogan(),
        ),
      ),
    );

    // Verificar se o texto "Arandú" está presente
    expect(find.text('Arandú'), findsOneWidget);

    // Verificar se o texto está usando o estilo correto
    final textFinder = find.text('Arandú');
    final textWidget = tester.widget<Text>(textFinder);
    final textStyle = textWidget.style;

    // Verificar se o texto usa a fonte "Amarante" do Google Fonts
    expect(textStyle?.fontFamily, GoogleFonts.amarante().fontFamily);

    // Verificar se o círculo de fundo está presente
    final circleFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(circleFinder);
    final decoration = containerWidget.decoration as BoxDecoration;

    // Verificar se o Container tem a forma de círculo
    expect(decoration.shape, BoxShape.circle);

    // Verificar se a cor do fundo é a cor primária do tema
    expect(decoration.color,
        Theme.of(tester.element(find.byType(Scaffold))).colorScheme.primary);
  });
}
