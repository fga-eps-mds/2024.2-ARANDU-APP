import 'package:aranduapp/ui/onboarding/view/onboarding_view.dart';
import 'package:aranduapp/ui/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<OnboardingViewModel>()])
import 'onboarding_test.mocks.dart';

void main() {
  late MockOnboardingViewModel mockOnboardingViewModel;

  setUp(() {
    mockOnboardingViewModel = MockOnboardingViewModel();

    // Define os comportamentos padrão para o mock
    when(mockOnboardingViewModel.currentPage).thenReturn(0);
    when(mockOnboardingViewModel.pageController).thenReturn(PageController());
    when(mockOnboardingViewModel.updateCurrentPage(any)).thenReturn(null);
    when(mockOnboardingViewModel.goToNextPage()).thenReturn(null);
    when(mockOnboardingViewModel.navigateToNextPage(any)).thenReturn(null);

    // Registra o mock como a instância do ViewModel usada pelo GetIt
    GetIt.I.registerSingleton<OnboardingViewModel>(mockOnboardingViewModel);
  });

  Widget createScreen() {
    return const MaterialApp(
      home: OnboardingView(),
    );
  }

  testWidgets('onboarding screen displays', (WidgetTester tester) async {
    await tester.pumpWidget(createScreen());

    expect(find.text('Bem-Vindo(a)!'), findsOneWidget);
    expect(find.text('o que você encontra?'), findsNothing);
    expect(find.text('Como funciona?'), findsNothing);
    expect(find.text('Avançar'), findsOneWidget);
    expect(find.text('Pular'), findsOneWidget);
  });
}
