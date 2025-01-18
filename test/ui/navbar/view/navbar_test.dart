import 'package:aranduapp/ui/navbar/view/navbar_view.dart';
import 'package:aranduapp/ui/navbar/viewmodel/navbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'navbar_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NavbarViewModel>()])
void main() {
  late MockNavbarViewModel mockNavbarViewModel;

  setUp(() {
    mockNavbarViewModel = MockNavbarViewModel();

    // Define os comportamentos padrão para o mock
    when(mockNavbarViewModel.selectedIndex).thenReturn(0);
    when(mockNavbarViewModel.hasListeners).thenReturn(false);

    // Registra o mock como a instância do ViewModel usada pelo GetIt
    GetIt.I.registerSingleton<NavbarViewModel>(mockNavbarViewModel);
  });

  Widget createScreen() {
    return const MaterialApp(
      home: NavbarView(),
    );
  }

  //testWidgets('Navbar screen displays', (WidgetTester tester) async {
//   await tester.pumpWidget(createScreen());

  // Verifique a presença do BottomNavigationBar
  //expect(find.byType(BottomNavigationBar), findsOneWidget);

  // Verifique se os itens de navegação (exceto Home) estão presentes
  //expect(find.byKey(Key('amigosTab')), findsOneWidget);
  //expect(find.byKey(Key('dashboardTab')), findsOneWidget);
  //expect(find.byKey(Key('perfilTab')), findsOneWidget);

  // Verifique se o índice selecionado foi chamado
  verify(mockNavbarViewModel.selectedIndex).called(1);

  // Verifique se o mock não foi chamado mais de uma vez
  // verifyNoMoreInteractions(mockNavbarViewModel);
  // });
}
