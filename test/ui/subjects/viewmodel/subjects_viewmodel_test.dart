import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/subjects/service/subjects_service.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'subjects_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SubjectService>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SubjectsViewmodel viewModel;
  late MockSubjectService mockSubjectService;

  setUp(() async {
    viewModel = SubjectsViewmodel();
    mockSubjectService = MockSubjectService();

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<SubjectService>(() => mockSubjectService);
  });

  test('Initial state should be correct', () {
    expect(viewModel.subjectCommand.isOk, false);
    expect(viewModel.subjectCommand.result, null);
  });

  test('Should load subjects successfully', () async {
    final mockSubjects = [
      SubjectModel(
        id: '1',
        name: 'Mathematics',
        shortName: 'MAT',
        description: 'Basic Mathematics',
      )
    ];
    const knowledgeId = 'knowledge_123';

    when(mockSubjectService.getSubjects(any))
        .thenAnswer((_) async => mockSubjects);

    await viewModel.subjectCommand.execute(knowledgeId);

    expect(viewModel.subjectCommand.isOk, true);
    expect(viewModel.subjectCommand.result!.asValue!.value, mockSubjects);
  });

  test('Should handle error when loading subjects fails', () async {
    const knowledgeId = 'knowledge_123';
    when(mockSubjectService.getSubjects(any))
        .thenThrow(Exception('Network error'));

    await viewModel.subjectCommand.execute(knowledgeId);

    expect(viewModel.subjectCommand.isError, true);
    expect(viewModel.subjectCommand.result!.asError!.error, isA<Exception>());
  });

  test('Should handle empty subject list', () async {
    const knowledgeId = 'knowledge_123';
    when(mockSubjectService.getSubjects(any)).thenAnswer((_) async => []);

    await viewModel.subjectCommand.execute(knowledgeId);

    expect(viewModel.subjectCommand.result!.asValue!.value, isEmpty);
  });
}
