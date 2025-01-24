import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lógica Booleana"),
          backgroundColor: Colors.transparent, // Fundo transparente
          elevation: 0, // Removendo a sombra da AppBar
          foregroundColor:
              Theme.of(context).colorScheme.onSurface, // Cor do texto
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Ícone de seta
            onPressed: () {
              // Ação para voltar à página anterior
              Navigator.pop(context); // Voltar para a página anterior
            },
            color: Theme.of(context).colorScheme.onSurface, // Cor da seta
          ),
        ),
        body: Consumer<ContentViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Container envolvendo o LinearProgressIndicator
                Container(
                  height: 10.0, // Ajuste a altura para a espessura da barra
                  child: LinearProgressIndicator(
                    value: viewModel.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary, // Cor do progresso
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _generateLongText(),
                      style: Theme.of(context).textTheme.bodyLarge?.apply(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Simula um texto longo
  String _generateLongText() {
    return List.generate(
            100,
            (index) =>
                "Linha $index: Esse é um texto longo do APP ARANDU! Esse é um texto longo do APP ARANDU! .\n")
        .join();
  }
}
