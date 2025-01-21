import 'package:aranduapp/ui/navbar/view/navbar_view.dart';
import 'package:aranduapp/ui/navbar/viewmodel/navbar_viewmodel.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'navbar_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NavbarViewModel>()])
void main() {
  late MockNavbarViewModel mockNavbarViewModel;

  setUp(() async {
    await GetIt.instance.reset();
    mockNavbarViewModel = MockNavbarViewModel();

    when(mockNavbarViewModel.selectedIndex).thenReturn(0);
    when(mockNavbarViewModel.hasListeners).thenReturn(false);

    GetIt.I.registerSingleton<NavbarViewModel>(mockNavbarViewModel);
    GetIt.I.registerLazySingleton<SubjectsViewmodel>(() => SubjectsViewmodel());
  });

  Widget createScreen() {
    return const MaterialApp(
      home: NavbarView(),
    );
  }

  testWidgets('Navbar screen displays', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    verify(mockNavbarViewModel.selectedIndex).called(greaterThanOrEqualTo(1));
  });
}
