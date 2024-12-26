import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aranduapp/ui/shared/TextPassword.dart';

void main() {
  // Testa a validação da senha no widget TextPassWord
  testWidgets('Testa se a senha é válida', (WidgetTester tester) async {
    final controller = TextEditingController();

    // Monta o widget de teste com TextPassWord
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextPassWord(
            controller: controller,
            padding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );

    // Localiza o campo de texto do formulário
    final passwordField = find.byType(TextFormField);

    // Função para testar diferentes cenários de validação de senha
    Future<void> testPassword(String input, String? expectedError) async {
      await tester.enterText(passwordField, input); // Insere texto no campo
      await tester.pump(); // Re-renderiza o widget para capturar mudanças
      final validator =
          tester.widget<TextFormField>(passwordField).validator!(input);
      expect(validator,
          expectedError); // Verifica se o erro retornado é o esperado
    }

    // Testa senhas inválidas, válidas e campo vazio
    await testPassword('12345', "Senha deve ter no mínimo 8 caracteres. (Ex: @abd1234)"); // Senha muito curta
    await testPassword('validPassword123', null); // Senha válida
    await testPassword('', 'Senha Obrigatória.'); // Campo vazio
  });

  // Testa a funcionalidade de visibilidade da senha
  testWidgets('Testa a visibilidade da senha', (WidgetTester tester) async {
    final controller = TextEditingController();

    // Monta o widget de teste com TextPassWord
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextPassWord(
            controller: controller,
            padding: const EdgeInsets.all(10),
          ),
        ),
      ),
    );

    // Localiza o ícone de visibilidade e o campo de texto
    final visibilityIcon = find.byIcon(Icons.visibility_off_outlined);
    final textFieldFinder = find.byType(TextField);

    // Verifica se o ícone inicial de visibilidade está presente
    expect(visibilityIcon, findsOneWidget);

    // Verifica o estado inicial de obscureText (deve ser verdadeiro)
    TextField textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.obscureText, true);

    // Simula o clique no ícone para alterar a visibilidade da senha
    await tester.tap(visibilityIcon);
    await tester.pump();

    // Verifica se o ícone foi alterado para o estado visível
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

    // Verifica se obscureText agora é falso
    textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.obscureText, false);

    // Simula outro clique para voltar a ocultar a senha
    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();

    // Verifica se o ícone voltou para o estado inicial
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

    // Verifica novamente se obscureText é verdadeiro
    textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.obscureText, true);
  });
}
