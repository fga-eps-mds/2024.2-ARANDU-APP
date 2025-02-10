import 'package:aranduapp/ui/knowledge/view/knowledge_view.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/knowledge/viewmodel/knowledge_viewmodel.dart';

@GenerateNiceMocks([
  MockSpec<KnowledgeViewmodel>(),
  MockSpec<Command1<List<Map<String, dynamic>>, Null>>(
      as: #MockCommand1WithTypes)
])
import 'knowledge_view_test.mocks.dart';

void main() {
  late MockKnowledgeViewmodel mockViewmodel;
  late MockCommand1WithTypes mockFetchKnowledgesCommand;

  setUp(() async {
    mockViewmodel = MockKnowledgeViewmodel();
    mockFetchKnowledgesCommand = MockCommand1WithTypes();

    when(mockFetchKnowledgesCommand.execute(null))
        .thenAnswer((_) async => Result.value([]));

    when(mockFetchKnowledgesCommand.running).thenReturn(false);
    when(mockFetchKnowledgesCommand.isError).thenReturn(false);

    when(mockViewmodel.fetchKnowledgesCommand)
        .thenReturn(mockFetchKnowledgesCommand);
    when(mockViewmodel.knowledges).thenReturn([]);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<KnowledgeViewmodel>(() => mockViewmodel);
  });

  Widget createKnowledgeScreen(MockKnowledgeViewmodel viewmodel) {
    return const MaterialApp(
      home: KnowledgeView(),
    );
  }

  testWidgets(
      'exibe indicador de carregamento quando o comando está executando',
      (WidgetTester tester) async {
    when(mockFetchKnowledgesCommand.running).thenReturn(true);

    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('exibe mensagem de erro quando o comando apresenta erro',
      (WidgetTester tester) async {
    when(mockFetchKnowledgesCommand.running).thenReturn(false);
    when(mockFetchKnowledgesCommand.isError).thenReturn(true);

    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    expect(find.text('Erro ao carregar os dados'), findsOneWidget);
  });

  testWidgets(
      'exibe mensagem "Nenhum dado disponível" quando a lista de conhecimentos está vazia',
      (WidgetTester tester) async {
    when(mockFetchKnowledgesCommand.running).thenReturn(false);
    when(mockFetchKnowledgesCommand.isError).thenReturn(false);
    when(mockViewmodel.knowledges).thenReturn([]);

    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    expect(find.text('Nenhum dado disponível'), findsOneWidget);
  });

  testWidgets('exibe o carrossel quando há dados de conhecimento',
      (WidgetTester tester) async {
    final sampleData = [
      {'name': 'Matemática'},
      {'name': 'Física'},
    ];

    when(mockFetchKnowledgesCommand.running).thenReturn(false);
    when(mockFetchKnowledgesCommand.isError).thenReturn(false);
    when(mockViewmodel.knowledges).thenReturn(sampleData);

    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    expect(find.text("Áreas de conhecimento"), findsOneWidget);
    expect(find.text('Matemática'), findsOneWidget);
    expect(find.text('Física'), findsOneWidget);
  });

  testWidgets('exibe o logo e a search bar', (WidgetTester tester) async {
    when(mockFetchKnowledgesCommand.running).thenReturn(false);
    when(mockFetchKnowledgesCommand.isError).thenReturn(false);
    when(mockViewmodel.knowledges).thenReturn([]);

    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    expect(find.text("Arandú"), findsOneWidget);
    expect(find.text('Pesquisar'), findsOneWidget);
  });

  testWidgets('chama fetchKnowledgesCommand.execute no initState',
      (WidgetTester tester) async {
    await tester.pumpWidget(createKnowledgeScreen(mockViewmodel));
    await tester.pump();

    verify(mockFetchKnowledgesCommand.execute(null)).called(1);
  });
}
