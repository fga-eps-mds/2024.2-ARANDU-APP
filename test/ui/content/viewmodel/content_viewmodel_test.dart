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

    when(mockContentService.getContentsById(any)).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2)); // Simula um delay
      return Result.value(ContentRequest(
        title: 'Teste',
        content: 'Conteúdo de teste',
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

  testWidgets('showing if content is loading or not',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      child: ListenableBuilder(
        listenable: viewModel.contentCommand,
        builder: (context, child) {
          if (viewModel.contentCommand.running) {
            return const CircularProgressIndicator();
          }
          return const Text('Conteúdo Carregado');
        },
      ),
    ));

    viewModel.contentCommand.execute('test-id');
    await tester.pump(); // Inicia o loading

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Conteúdo Carregado'), findsOneWidget);
  });

  testWidgets('progressbar is working or not', (WidgetTester tester) async {
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
                child: const Text('Conteúdo longo'),
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

    expect(viewModel.progress, greaterThan(0.0));
  });
}
