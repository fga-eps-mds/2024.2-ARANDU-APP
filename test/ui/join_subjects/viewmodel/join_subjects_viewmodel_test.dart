import 'package:aranduapp/ui/join_subjects/service/join_subjects_service.dart';
import 'package:aranduapp/ui/join_subjects/viewmodel/join_subjects_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'join_subjects_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JoinSubjectsService>()])

Future<void> main() async {

  late MockJoinSubjectsService mockJoinSubjectsService;
  late JoinSubjectsViewmodel joinSubjectsViewmodel;

  setUp(() async {
    joinSubjectsViewmodel = JoinSubjectsViewmodel();
    mockJoinSubjectsService = MockJoinSubjectsService();

    await GetIt.instance.reset();


    GetIt.I.registerLazySingleton<JoinSubjectsService>(() => mockJoinSubjectsService);
  });

  test('joinsubjects should call joinSubjects service and return success', () async {
    const String subjectId = '123';

    when(mockJoinSubjectsService.joinSubjects(subjectId))
        .thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
    });

    await joinSubjectsViewmodel.joinsubjectsCommand.execute(subjectId);

    expect(joinSubjectsViewmodel.joinsubjectsCommand.isOk, isTrue);
    verify(mockJoinSubjectsService.joinSubjects(subjectId)).called(1);
  });

  test('join subjects should return error if service fails', () async {
    const String subjectId = '123';

    when(mockJoinSubjectsService.joinSubjects(subjectId))
        .thenThrow(Exception('Failed to join subject'));

    await joinSubjectsViewmodel.joinsubjectsCommand.execute(subjectId);

    expect(joinSubjectsViewmodel.joinsubjectsCommand.isError, isTrue);
    verify(mockJoinSubjectsService.joinSubjects(subjectId)).called(1);
  });

}