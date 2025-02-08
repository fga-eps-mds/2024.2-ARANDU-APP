import 'package:aranduapp/ui/home/view/subject_by_knowledges_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/home/viewmodel/home_viewmodel.dart';
import 'package:aranduapp/ui/shared/grafismo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = GetIt.instance<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.fetchKnowledges();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        flexibleSpace: CustomPaint(
          size: Size(double.infinity, kToolbarHeight),
          painter: CustomPatternPainter(colors),
        ),
      ),
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
              _knowledgeCarousel(context),
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
                borderRadius: const BorderRadius.all(
                    Radius.circular(12.0)), // Borda arredondada
                side: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface, // Borda com cor dinâmica
                ),
              ),
            ),
            elevation:
                const WidgetStatePropertyAll<double>(0.0), // Remove a elevação
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
    required Map<String, dynamic> item,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => subjectsByKnowledgesView(
                    knowledgeId: item['_id'].toString(),
                    subjectName: item['name'].toString())));
      },
      borderRadius: BorderRadius.circular(4.0),
      child: Card(
        elevation: 4.0,
        child: SizedBox(
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
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.onTertiary,
                width: double.infinity,
                child: Text(
                  item['name'].toString(),
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

  Widget _knowledgeCarousel(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel, // Observa o HomeViewModel
      builder: (context, child) {
        if (viewModel.isLoading) {
          return const Center(
              child: CircularProgressIndicator()); // Exibe um loading
        } else if (viewModel.erroMessage != null) {
          return const Center(
              child: Text(
                  'Erro ao carregar os dados')); // Exibe uma mensagem de erro
        } else if (viewModel.knowledges.isEmpty) {
          return const Center(
              child: Text(
                  'Nenhum dado disponível')); // Exibe uma mensagem se não houver dados
        }
        final knowledgeItems = viewModel.knowledges;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Áreas de conhecimento",
                style: TextStyle(
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
                    child: _knowledgecard(context: context, item: item),
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
