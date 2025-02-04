import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/home/model/home_model.dart';
import 'package:aranduapp/ui/home/viewmodel/home_viewmodel.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: GetIt.instance<HomeViewModel>(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.instance<HomeViewModel>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(context),
              const SizedBox(height: 20),
              _searchbar(context),
              const SizedBox(height: 40),
              _knowledgeCarousel(context, "Áreas de conhecimento", viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double circleDiameter = screenSize.longestSide * 0.7;
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Círculo de fundo
              Container(
                width: circleDiameter * 0.3,
                height: circleDiameter * 0.3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              // Imagem com deslocamento para a esquerda
              Transform.translate(
                offset: const Offset(-10, 0), // Move 30 pixels para a esquerda
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: circleDiameter * 0.24,
                  height: circleDiameter * 0.24,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Text(
            "Arandú",
            style: GoogleFonts.amarante(
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            backgroundColor: WidgetStatePropertyAll<Color>(
              Theme.of(context).colorScheme.surface, // Cor de fundo
            ),
            hintText: 'Pesquisar', // Texto dentro do campo
            leading: const Icon(Icons.search), // Ícone da lupa
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(12.0)), // Borda arredondada
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface, // Borda com cor dinâmica
                ),
              ),
            ),
            elevation: WidgetStatePropertyAll<double>(0.0), // Remove a elevação
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String materia = 'Materia $index';
            return ListTile(
              title: Text(materia),
              onTap: () {
                controller.closeView(materia);
              },
            );
          });
        },
      ),
    );
  }

  Widget _knowledgecard({
    required BuildContext context,
    required String title,
  }) {
    return InkWell(
      onTap: () {
        print('Card "$title" foi tocado!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Você tocou no card: $title')),
        );
      },
      borderRadius: BorderRadius.circular(4.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          width: 360,
          height: 116,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Center(
                    child: Icon(
                      Icons.calculate,
                      size: 50,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.onTertiary,
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _knowledgeCarousel(
      BuildContext context, String titulo, HomeViewModel viewModel) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        // Dispara a busca se o comando não foi executado e não está em andamento
        if (!viewModel.getHomeCommand.isOk &&
            !viewModel.getHomeCommand.running) {
          Future.microtask(() => viewModel.fetchKnowledges());
        }

        if (viewModel.getHomeCommand.running) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.getHomeCommand.isError) {
          return const Center(child: Text('Erro ao carregar os dados'));
        }

        final knowledgeItems =
            viewModel.getHomeCommand.result?.asValue?.value ?? [];
        if (knowledgeItems.isEmpty) {
          return const Center(child: Text('Nenhum dado disponível'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 3 / 1.2,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.5,
                  initialPage: 2,
                ),
                itemCount: knowledgeItems.length,
                itemBuilder: (context, index) {
                  final item = knowledgeItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _knowledgecard(
                      context: context,
                      title: item.name,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
