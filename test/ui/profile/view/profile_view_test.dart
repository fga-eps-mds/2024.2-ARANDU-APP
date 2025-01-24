import 'package:aranduapp/core/state/command.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:aranduapp/ui/login/viewmodel/login_viewmodel.dart';
import 'package:aranduapp/ui/profile/view/profile_view.dart';
import 'package:aranduapp/ui/profile/viewmodel/profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProfileViewModel>(),
  MockSpec<Command0>(),
])
void main() {
  late MockProfileViewModel mockProfileViewModel;
  late MockCommand0 mocklogoutCommand0;

  setUp(() async {
    mockProfileViewModel = MockProfileViewModel();
    mocklogoutCommand0 = MockCommand0();

    when(mockProfileViewModel.logoutCommand).thenReturn(mocklogoutCommand0);
    when(mocklogoutCommand0.running).thenReturn(false);
    when(mocklogoutCommand0.isOk).thenReturn(false);
    when(mocklogoutCommand0.running).thenReturn(false);

    await GetIt.instance.reset();
    GetIt.I.registerSingleton<ProfileViewModel>(mockProfileViewModel);
    GetIt.I.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  });
  Widget createScreen() {
    return const MaterialApp(
      home: Profile(),
    );
  }

  testWidgets('Profile screen displays', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ProfileHeader), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Editar'), findsOneWidget);
    expect(find.text('Trocar senha'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);
  });

  testWidgets('tap logout', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('logout_button')));

    await tester.pumpAndSettle();

    verify(mocklogoutCommand0.execute()).called(1);
  });

  testWidgets('logout', (WidgetTester tester) async {
    when(mocklogoutCommand0.isOk).thenReturn(true);

    await tester.pumpWidget(createScreen());

    await tester.pumpAndSettle();

    expect(find.byType(Login), findsOneWidget);
  });
}
