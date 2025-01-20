import 'package:aranduapp/ui/profile/view/profile_view.dart';
import 'package:aranduapp/ui/profile/viewmodel/profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileViewModel>()])
void main() {
  late MockProfileViewModel mockProfileViewModel;

  setUp(() {
    mockProfileViewModel = MockProfileViewModel();

    // Define os comportamentos padrão para o mock
    when(mockProfileViewModel.isLoading)
        .thenReturn(false); // Simula que o carregamento não está acontecendo
    when(mockProfileViewModel.formKey).thenReturn(GlobalKey<FormState>());
    when(mockProfileViewModel.emailController)
        .thenReturn(TextEditingController());

    // Registra o mock como a instância do ViewModel usada pelo GetIt
    GetIt.I.registerSingleton<ProfileViewModel>(mockProfileViewModel);
  });
  Widget createScreen() {
    return const MaterialApp(
      home: Profile(),
    );
  }

  testWidgets('Profile screen displays', (WidgetTester tester) async {
    // Carrega a tela
    await tester.pumpWidget(createScreen());

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ProfileHeader), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Editar'), findsOneWidget);
    expect(find.text('Trocar senha'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);
  });
}
