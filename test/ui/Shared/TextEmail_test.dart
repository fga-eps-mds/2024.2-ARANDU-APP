import 'package:aranduapp/ui/shared/TextEmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testa se Email é válido ou inválido',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextEmail(
              padding: const EdgeInsets.all(10), controller: controller),
        ),
      ),
    );

    final emailField = find.byType(TextFormField);

    // Função auxiliar para validar diferentes entradas de e-mail
    Future<void> testEmail(String input, String? expectedError) async {
      await tester.enterText(emailField, input);
      await tester.pump();
      final validator =
          tester.widget<TextFormField>(emailField).validator!(input);
      expect(validator, expectedError);
    }

    // Teste de validação para diferentes casos
    await testEmail("", "E-mail inválido"); // Campo vazio
    await testEmail("joaozinhi", "E-mail inválido"); // Sem '@'
    await testEmail("joaozinhi@", "E-mail inválido"); // Sem domínio
    await testEmail("joao@domain", "E-mail inválido"); // Sem extensão
    await testEmail("joao@example.com", null); // Entrada válida
  });
}
