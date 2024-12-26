import 'package:aranduapp/ui/shared/TextName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testa se o nome é válido', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: TextName(
        controller: controller,
        padding: const EdgeInsets.all(10),
      ),
    )));

    final nameField = find.byType(TextFormField);

    // Função auxiliar para validar diferentes entradas de nome
    Future<void> testName(String input, String? expectedError) async {
      await tester.enterText(nameField, input);
      await tester.pump();
      final validator =
          tester.widget<TextFormField>(nameField).validator!(input);
      expect(validator, expectedError);
    }

    // Teste de validação para diferentes casos de nome
    await testName("", 'Nome Obrigatório.'); // Campo vazio
    await testName("  a", 'Opa, seu Nome está pequeno! \n acrescente mais caracteres. (Ex: Ana)'); // Nome com menos de 3 caracteres
    await testName("Jo", 'Opa, seu Nome está pequeno!\n acrescente mais um caractere. (Ex: Ana)'); // Nome com 2 caracteres
    await testName("João", null); // Nome válido
    await testName("Maria", null); // Outro nome válido
  });
}
