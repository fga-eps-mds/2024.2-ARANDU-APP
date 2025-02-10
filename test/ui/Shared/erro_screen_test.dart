import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';

void main() {
  testWidgets('Testa ErrorScreen', (WidgetTester tester) async {
    const errorMessage = 'Esta é uma mensagem de erro de teste.';

    await tester.pumpWidget(
      const MaterialApp(
        home: ErrorScreen(message: errorMessage),
      ),
    );

    expect(find.byIcon(Icons.error_sharp), findsOneWidget);

    expect(find.text('Algo deu errado...'), findsOneWidget);

    expect(find.text(errorMessage), findsOneWidget);
   
    final iconFinder = find.byIcon(Icons.error_sharp);
    final Icon iconWidget = tester.widget(iconFinder);
    expect(iconWidget.color, isNotNull); 

    final textFinder1 = find.text('Algo deu errado...');
    final Text textWidget1 = tester.widget(textFinder1);
    expect(textWidget1.style?.color, isNotNull); 

     final textFinder2 = find.text(errorMessage);
    final Text textWidget2 = tester.widget(textFinder2);
    expect(textWidget2.style?.color, isNotNull); 
   
  });
}
