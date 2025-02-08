import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/content/view/content_view.dart';
import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<ContentViewModel>(),
  MockSpec<Command1<ContentRequest, String>>(),
])
import 'content_view_test.mocks.dart';

void main() {
  late MockContentViewModel mockContentViewModel;
  late MockCommand1 mockCommand;

  setUp(() {
    mockContentViewModel = MockContentViewModel();
    mockCommand = MockCommand1();

    // Configuração correta do mock para contentCommand
    when(mockContentViewModel.contentCommand).thenReturn(mockCommand);
    when(mockContentViewModel.scrollController).thenReturn(ScrollController());

    // Configuração do GetIt
    GetIt.I.registerSingleton<ContentViewModel>(mockContentViewModel);
  });

  tearDown(() {
    GetIt.I.unregister<ContentViewModel>(instance: mockContentViewModel);
  });

  Widget createScreen() {
    return const MaterialApp(
      home: ContentView(contentID: 'test-id'),
    );
  }

  testWidgets('showing loading', (tester) async {
    // Configura o estado do command
    when(mockCommand.running).thenReturn(true);

    await tester.pumpWidget(createScreen());
    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets('showing content', (tester) async {
    final mockContent = ContentRequest(
        title: 'Título Teste',
        content: 'Conteúdo **Markdown**',
        trailID: 'trail-123');

    // Configura o command para sucesso
    when(mockCommand.isOk).thenReturn(true);
    when(mockContentViewModel.content).thenReturn(mockContent);
    when(mockContentViewModel.progress).thenReturn(0.5);
    when(mockContentViewModel.estimatedReadingTime).thenReturn('2 min');

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.text('Título Teste'), findsOneWidget);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });
}
