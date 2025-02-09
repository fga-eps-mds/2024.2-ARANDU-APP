import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/view/journey_view.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'journey_view_test.mocks.dart';


@GenerateNiceMocks([MockSpec<JourneyViewModel>(), MockSpec<Command1>()])
void main() {
  late MockJourneyViewModel mockViewModel;
  late MockCommand1<List<JourneyModel>, String> mockGetJourneyCommand;
  final testSubject =
      SubjectModel(id: '1', name: 'Matemática', shortName: 'Mat', description:'Desvende os mistérios da Matemática e expanda seus horizontes intelectuais.');

  setUp(() async {
    mockViewModel = MockJourneyViewModel();

    mockGetJourneyCommand = MockCommand1();
    when(mockViewModel.getJourneyCommand).thenReturn(mockGetJourneyCommand);
    when(mockGetJourneyCommand.running).thenReturn(false);
    when(mockGetJourneyCommand.isError).thenReturn(false);
    when(mockGetJourneyCommand.isOk).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<JourneyViewModel>(() => mockViewModel);
  });

  Widget createJourneyScreen() {
    return MaterialApp(
      home: Journey(subject: testSubject),
    );
  }

  testWidgets('Should show LoadingWidget initially',
      (WidgetTester tester) async {
    when(mockGetJourneyCommand.running).thenReturn(true);

    await tester.pumpWidget(createJourneyScreen());

    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets('Should show journey list when command is successful',
      (WidgetTester tester) async {
    final testJourneys = [
      JourneyModel(id: '1', title: 'Jornada 1', description: 'Descrição 1'),
      JourneyModel(id: '2', title: 'Jornada 2', description: 'Descrição 2'),
    ];

    when(mockGetJourneyCommand.isOk).thenReturn(true);
    when(mockGetJourneyCommand.result).thenReturn(Result.value(testJourneys));

    await tester.pumpWidget(createJourneyScreen());
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Jornada 1'), findsOneWidget);
    expect(find.text('Jornada 2'), findsOneWidget);
  });

  testWidgets('Should show error when command fails',
      (WidgetTester tester) async {
    when(mockGetJourneyCommand.isError).thenReturn(true);
    when(mockGetJourneyCommand.result)
        .thenReturn(Result.error('Erro de conexão'));

    await tester.pumpWidget(createJourneyScreen());
    await tester.pumpAndSettle();

    expect(find.byType(ErrorScreen), findsOneWidget);
    expect(find.text('Deslize para baixo \n\n Erro de conexão'), findsOneWidget);

    expect(find.text('Algo deu errado...'), findsOneWidget);
  });

  testWidgets('Should call execute command when screen starts',
      (WidgetTester tester) async {
    await tester.pumpWidget(createJourneyScreen());
    verify(mockGetJourneyCommand.execute(testSubject.id)).called(1);
  });

  testWidgets('Should call execute command again when performing refresh on the screen',
      (WidgetTester tester) async {
    when(mockGetJourneyCommand.isOk).thenReturn(true);
    when(mockGetJourneyCommand.result).thenReturn(Result.value([
      JourneyModel(id: '1', title: 'Jornada 1', description: 'Descrição 1'),
    ]));
  
    await tester.pumpWidget(createJourneyScreen());
    await tester.pumpAndSettle();

    // Simulate a pull-to-refresh
    await tester.fling(find.byType(ListView),const Offset(0.0, 300.0),1000.0,);
    await tester.pumpAndSettle();

    verify(mockGetJourneyCommand.execute(testSubject.id)).called(greaterThan(1));
  });
  

}
