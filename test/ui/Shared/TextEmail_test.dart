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
    await testEmail("", "E-mail Obrigatório."); // Campo vazio
    await testEmail("joaozinhi", "Opa, E-mail inválido! (Ex: exemplo@gmail.com)"); // Sem '@'
    await testEmail("joaozinhi@", "Opa, E-mail inválido! (Ex: exemplo@gmail.com)"); // Sem domínio
    await testEmail("joao@domain", "Opa, E-mail inválido! (Ex: exemplo@gmail.com)"); // Sem extensão
    await testEmail("joao@example.com", null); // Entrada válida
  });
}
