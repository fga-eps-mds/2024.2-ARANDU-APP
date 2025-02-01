import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              _knowledgecard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double circleDiameter = screenSize.longestSide * 0.7;
    double nameSize = screenSize.height * 0.07;

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
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
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

  Widget _knowledgecard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.45;
    final cardHeight = screenHeight * 0.2;

    return InkWell(
      onTap: () {
        // Ação ao tocar no card
        print('Card foi tocado!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Você tocou no card de Cálculo 1!')),
        );
      },
      borderRadius: BorderRadius.circular(4.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          width: cardWidth,
          height: cardHeight,
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
                  'Cálculo 1',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
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
}
