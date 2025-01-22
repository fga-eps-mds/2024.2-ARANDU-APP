import 'package:aranduapp/ui/subjects/view/subjects_view.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SubjectsViewmodel>()])
import 'subjects_view_test.mocks.dart';

void main() {
  late MockSubjectsViewmodel mockSubjectsViewmodel;

  setUp(() async{
    mockSubjectsViewmodel = MockSubjectsViewmodel();

    when(mockSubjectsViewmodel.subjectCommand.isOk).thenReturn(false);
    when(mockSubjectsViewmodel.subjectCommand.isError).thenReturn(false);
    when(mockSubjectsViewmodel.subjectCommand.running).thenReturn(true);

    await GetIt.I.reset();
    GetIt.I.registerSingleton<SubjectsViewmodel>(mockSubjectsViewmodel);
  });

  tearDown(() {
    GetIt.I.unregister<SubjectsViewmodel>();
  });

  Widget createScreen() {
    return const MaterialApp( home: Subject(),
    );
  }



}
