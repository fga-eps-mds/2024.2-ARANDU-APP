import 'package:aranduapp/core/network/auth_api.dart';
import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/join_subjects/view/join_subjects_view.dart';
import 'package:aranduapp/ui/join_subjects/viewmodel/join_subjects_viewmodel.dart';
import 'package:aranduapp/ui/journey/view/journey_view.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'join_subjects_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JoinSubjectsViewmodel>(), MockSpec<Command1>()])
void main(){
  late MockJoinSubjectsViewmodel mockJoinSubjectsViewmodel;
  late MockCommand1<void, String> mockJoinsubjectsCommand1;

  final testSubject =
  SubjectModel(id: '1', name: 'calculo1', shortName: '', description: 'derivadas');

  setUp(() async {
    mockJoinSubjectsViewmodel = MockJoinSubjectsViewmodel();
    mockJoinsubjectsCommand1 = MockCommand1();

    when(mockJoinSubjectsViewmodel.joinsubjectsCommand).thenReturn(mockJoinsubjectsCommand1);

    when(mockJoinsubjectsCommand1.running).thenReturn(false);
    when(mockJoinsubjectsCommand1.isError).thenReturn(false);
    when(mockJoinsubjectsCommand1.isOk).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<JoinSubjectsViewmodel>(
            () => mockJoinSubjectsViewmodel);
    GetIt.I.registerLazySingleton<JourneyViewModel>(() => JourneyViewModel());
  });

  Widget createScreen() {
    return MaterialApp(
      home: JoinSubjects(subject: testSubject),
    );
  }

  testWidgets('Join subjects screen display', (WidgetTester tester) async{
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text(testSubject.name), findsNWidgets(2));
    expect(find.byIcon(Icons.book), findsOneWidget);
    expect(find.text(testSubject.description), findsOneWidget);
    expect(find.byType(CommandButton), findsOneWidget);
  });

  testWidgets('checks if when pressing the button it passes an ID', (WidgetTester tester) async{
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('elevated_button_key')));
    await tester.pumpAndSettle();

    verify(mockJoinsubjectsCommand1.execute(testSubject.id)).called(1);

  });
  testWidgets('navigates to SubjectsView after successful join', (WidgetTester tester) async {
    when(mockJoinsubjectsCommand1.isOk).thenReturn(true);

    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();

    expect(find.byType(Journey), findsOneWidget);
  });

}