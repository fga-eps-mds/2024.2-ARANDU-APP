import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/journey/model/journey_request.dart';
import 'package:aranduapp/ui/journey/service/journey_service.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'journey_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JourneyService>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late JourneyViewModel viewModel;
  late MockJourneyService mockJourneyService;

  setUp(() async {
    viewModel = JourneyViewModel();
    mockJourneyService = MockJourneyService();

    await GetIt.instance.reset();
    GetIt.I.registerLazySingleton<JourneyService>(() => mockJourneyService);

    viewModel.getJourneyCommand =
        Command1<List<JourneyModel>, String>(viewModel.getJourney);
  });

  test('Should have correct initial state', () {
    expect(viewModel.getJourneyCommand.isOk, false);
    expect(viewModel.getJourneyCommand.isError, false);
    expect(viewModel.getJourneyCommand.result, null);
  });

  test('Should load journeys successfully', () async {
    final mockJourneys = [
      JourneyModel(id: '1', title: 'Journey 1', description: 'Description 1'),
      JourneyModel(id: '2', title: 'Journey 2', description: 'Description 2'),
    ];
    const subjectId = '123';
    when(mockJourneyService.getJourneys(any))
        .thenAnswer((_) async => mockJourneys);

    await viewModel.getJourneyCommand.execute(subjectId);

    expect(viewModel.getJourneyCommand.isOk, true);
    expect(viewModel.getJourneyCommand.result!.asValue!.value, mockJourneys);

    verify(mockJourneyService.getJourneys(argThat(isA<JourneyRequest>())))
        .called(1);
  });

  test('Should handle error when loading journeys fails', () async {
    const subjectId = '123';
    when(mockJourneyService.getJourneys(any))
        .thenThrow(Exception('Failed to load journeys'));

    await viewModel.getJourneyCommand.execute(subjectId);

    expect(viewModel.getJourneyCommand.isError, true);
    expect(viewModel.getJourneyCommand.result!.asError!.error, isA<Exception>());
    verify(mockJourneyService.getJourneys(argThat(isA<JourneyRequest>()))).called(1);
  });

  test('Should call getJourneys with the correct subjectId', () async {
    // Arrange
    final mockJourneys = [
      JourneyModel(id: '1', title: 'Journey 1', description: 'Description 1'),
    ];
    const subjectId = '123';
    when(mockJourneyService.getJourneys(any))
        .thenAnswer((_) async => mockJourneys);

    // Act
    await viewModel.getJourneyCommand.execute(subjectId);

    // Assert
    verify(mockJourneyService.getJourneys(argThat(
            predicate<JourneyRequest>((req) => req.subjectId == subjectId))))
        .called(1);
  });

   test('Should handle empty journey list', () async {
    // Arrange
    const subjectId = '123';
    when(mockJourneyService.getJourneys(any)).thenAnswer((_) async => []);

    // Act
    await viewModel.getJourneyCommand.execute(subjectId);

    // Assert
    expect(viewModel.getJourneyCommand.isOk, true);
    expect(viewModel.getJourneyCommand.result!.asValue!.value, isEmpty);
  });

}


