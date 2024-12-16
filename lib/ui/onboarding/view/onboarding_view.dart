import 'package:flutter/material.dart';
import 'package:aranduapp/ui/register_account/view/RegisterAccount.dart';
import 'package:provider/provider.dart';
import '../viewModel/onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  final List<Map<String, String>> steps = const [
    {
      'title': 'Bem-Vindo(a)!',
      'description':
          'Seja bem vindo ao Arandu!!! Sou um ambiente voltado para aprendizado de forma gratuita',
      'imageAsset': 'assets/images/Component1.png',
    },
    {
      'title': 'o que você encontra?',
      'description':
          'Aqui você encontrará livros interativos de diversas disciplinas com objetivo de entregar praticidade e qualidade no aprendizado.',
      'imageAsset': 'assets/images/Component2.png',
    },
    {
      'title': 'Como funciona?',
      'description':
          'Para acessar uma trilha basta se inscrever na disciplina de sua preferência e ter acesso aos materiais. \n Bons estudos !!!',
      'imageAsset': 'assets/images/Component3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: null,
            body: LayoutBuilder(
              builder: (context, constraints) {
                final double imageHeight = constraints.maxHeight * 0.60;
                final double contentHeight = constraints.maxHeight * 0.55;
                final double buttonHeight = constraints.maxHeight * 0.15;

                return Stack(
                  children: [
                    _buildSemicirclePage(context),
                    _buildImageSection(viewModel, steps, imageHeight),
                    _buildContentSection(viewModel, steps, contentHeight),
                    _buildNavigationButtons(
                        context, viewModel, steps, buttonHeight),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageSection(OnboardingViewModel viewModel,
      List<Map<String, String>> steps, double height) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Container(
          key: ValueKey<String>(steps[viewModel.currentPage]['imageAsset']!),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(steps[viewModel.currentPage]['imageAsset']!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(OnboardingViewModel viewModel,
      List<Map<String, String>> steps, double height) {
    return Positioned(
      top: height,
      left: 0,
      right: 0,
      height: height,
      child: PageView.builder(
        controller: viewModel.pageController,
        itemCount: steps.length,
        onPageChanged: viewModel.updateCurrentPage,
        itemBuilder: (context, index) {
          final step = steps[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title']!,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      step['description']!,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSemicirclePage(BuildContext context) {
    return Positioned(
      top: 0,
      left: -MediaQuery.of(context).size.width * 0.3, // Desloca para a esquerda
      child: Container(
        width:
            MediaQuery.of(context).size.width * 1.3, // Largura maior que a tela
        height:
            MediaQuery.of(context).size.height * 0.4, // Altura do semicírculo
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(MediaQuery.of(context).size.height * 0.5),
            bottomRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
      BuildContext context,
      OnboardingViewModel viewModel,
      List<Map<String, String>> steps,
      double height) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (viewModel.currentPage < steps.length - 1)
              TextButton(
                onPressed: () => viewModel.navigateToRegister(context),
                child: Text(
                  'Pular',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            if (viewModel.currentPage < steps.length - 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: viewModel.goToNextPage,
                child: Text(
                  'Avançar',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            if (viewModel.currentPage == steps.length - 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => viewModel.navigateToRegister(context),
                child: Text(
                  'Começar',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
