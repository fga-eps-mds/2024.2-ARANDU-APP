import 'package:aranduapp/ui/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: Consumer<ContentViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Barra de progresso
                Container(
                  height: 10.0,
                  child: LinearProgressIndicator(
                    value: viewModel.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // Conteúdo rolável
                Expanded(
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _generateLongText(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                // Botão "Finalizar", exibido somente quando permitido pela ViewModel
                if (viewModel.shouldShowButton)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        _showCompletionDialog(context);
                      },
                      child: Text(
                        'Finalizar',
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
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

  String _generateLongText() {
    return List.generate(100,
            (index) => "Linha $index: Esse é um texto longo do APP ARANDU! .\n")
        .join();
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
                width: 250,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Conteúdo Finalizado!  Voltando para trilha.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.apply(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary, // Cor laranja para o botão
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                          (Route<dynamic> route) =>
                              false, // Limpa a pilha de navegação
                        );
                      },
                      child: Text(
                        'Trilha',
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}
