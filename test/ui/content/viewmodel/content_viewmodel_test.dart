import 'package:aranduapp/ui/content/model/content_request.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:get_it/get_it.dart';

import 'content_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ContentService>()])
void main() {
  late ContentViewModel viewModel;
  late MockContentService mockContentService;
  final getIt = GetIt.instance;

  setUp(() {
    mockContentService = MockContentService();

    getIt.registerSingleton<ContentService>(mockContentService);

    viewModel = ContentViewModel();

    // Simulando a API corretamente
    when(mockContentService.getContentsById(any)).thenAnswer((_) async {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simula pequeno delay
      return Result.value(ContentRequest(
        title: 'Test',
        content: 'Test content',
        trailID: 'trail-123',
      ));
    });
  });

  tearDown(() {
    getIt.unregister<ContentService>();
    viewModel.dispose();
  });

  Widget createTestWidget({required Widget child}) {
    return MaterialApp(
      home: ChangeNotifierProvider<ContentViewModel>(
        create: (_) => viewModel,
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets('Should update UI when state changes',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      child: ListenableBuilder(
        listenable: viewModel.contentCommand,
        builder: (context, child) {
          if (viewModel.contentCommand.running) {
            return const CircularProgressIndicator();
          }
          return const Text('Content Loaded');
        },
      ),
    ));

    viewModel.contentCommand.execute('test-id');
    await tester.pump(); // Começa a carregar

    // Agora verifica se o indicador de carregamento aparece
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(); // Aguarda finalização do carregamento

    // Verifica se o conteúdo carregado aparece corretamente
    expect(find.text('Content Loaded'), findsOneWidget);
  });

  testWidgets(
      'Should show loading indicator while async operation is in progress',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      child: ListenableBuilder(
        listenable: viewModel.contentCommand,
        builder: (context, child) {
          if (viewModel.contentCommand.running) {
            return const CircularProgressIndicator();
          }
          return const Text('Content Loaded');
        },
      ),
    ));

    // Simula carregamento
    viewModel.contentCommand.execute('test-id');
    await tester.pump();

    // O indicador de carregamento deve estar na tela
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(); // Aguarda finalização

    // Agora, o conteúdo carregado deve aparecer
    expect(find.text('Content Loaded'), findsOneWidget);
  });

  testWidgets('Progress bar is working correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return LinearProgressIndicator(
                    value: viewModel.progress); // Barra de progresso
              },
            ),
            SizedBox(
              height: 1000,
              child: SingleChildScrollView(
                key: const Key('scrollableContent'),
                controller: viewModel.scrollController,
                child: const Text('Long content'),
              ),
            ),
          ],
        ),
      ),
    ));

    await tester.drag(
        find.byKey(const Key('scrollableContent')), const Offset(0, -500));
    await tester.pumpAndSettle();

    viewModel.scrollController.notifyListeners();
    await tester.pump();

    expect(viewModel.progress,
        greaterThan(0.0)); // Checa se a barra de progresso atualizou
  });
  testWidgets('Should display loading indicator when request is in progress',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      child: ListenableBuilder(
        listenable: viewModel.contentCommand,
        builder: (context, child) {
          if (viewModel.contentCommand.running) {
            return const CircularProgressIndicator();
          }
          return const Text('Content Loaded');
        },
      ),
    ));

    // Execute request
    viewModel.contentCommand.execute('test-id');
    await tester.pump();

    // Check if loading indicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle(); // Wait for loading to finish

    // Verify content is displayed
    expect(find.text('Content Loaded'), findsOneWidget);
  });
}
