import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:aranduapp/ui/subjects/view/subjects_view.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

@GenerateNiceMocks([MockSpec<SubjectsViewmodel>()])
import 'subjects_view_test.mocks.dart';

void main() {
  late MockSubjectsViewmodel mockSubjectsViewmodel;

  setUp(() {
    mockSubjectsViewmodel = MockSubjectsViewmodel();

    // Verifique se o singleton já está registrado e resete se necessário
    if (GetIt.I.isRegistered<SubjectsViewmodel>()) {
      GetIt.I.unregister<SubjectsViewmodel>();
    }
    GetIt.I.registerSingleton<SubjectsViewmodel>(mockSubjectsViewmodel);

    // Configuração básica de mocks
    when(mockSubjectsViewmodel.subjectCommand.isOk).thenReturn(false);
    when(mockSubjectsViewmodel.subjectCommand.isError).thenReturn(false);
    when(mockSubjectsViewmodel.subjectCommand.isLoading).thenReturn(true);
  });

  tearDown(() {
    GetIt.I.unregister<SubjectsViewmodel>();
  });

  Widget createTestWidget() {
    return ChangeNotifierProvider<SubjectsViewmodel>.value(
      value: mockSubjectsViewmodel,
      child: const MaterialApp(
        home: SubjectScreen(),
      ),
    );
  }

  testWidgets('Displays loading widget while data is loading',
      (WidgetTester tester) async {
    when(mockSubjectsViewmodel.subjectCommand.isLoading).thenReturn(true);

    await tester.pumpWidget(createTestWidget());

    // Verifica se o widget de carregamento está na tela
    expect(find.byType(LoadingWidget), findsOneWidget);
  });


}
