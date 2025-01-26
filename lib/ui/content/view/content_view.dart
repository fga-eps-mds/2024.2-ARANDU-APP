import 'package:flutter/material.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:flutter_html/flutter_html.dart'; // Pacote para renderizar HTML
import 'package:aranduapp/ui/home/view/home_view.dart';

class ContentView extends StatelessWidget {
  final String contentID;

  const ContentView({super.key, required this.contentID});

  @override
  Widget build(BuildContext context) {
    final ContentService contentService = ContentService();

    return ChangeNotifierProvider(
      create: (context) => ContentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Map<String, dynamic>?>(
            future: contentService.getContentsById(contentID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Carregando...");
              } else if (snapshot.hasError) {
                return const Text("Erro");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("Conteúdo não encontrado");
              }
              final content = snapshot.data!;
              return Text(content['title']);
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
        body: FutureBuilder<Map<String, dynamic>?>(
          future: contentService.getContentsById(contentID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar conteúdo"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Conteúdo não encontrado"));
            }

            final content = snapshot.data!;

            return Consumer<ContentViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    // Barra de progresso
                    SizedBox(
                      height: 10.0,
                      child: LinearProgressIndicator(
                        value: viewModel.progress,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    // Conteúdo rolável com altura mínima garantida
                    Expanded(
                      child: SingleChildScrollView(
                        controller: viewModel.scrollController,
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          // Adicionando uma altura mínima para garantir a rolagem
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context)
                                .size
                                .height, // Garante altura mínima
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _renderContent(content['content']),
                              if (viewModel.shouldShowButton) ...[
                                // Botão "Finalizar", exibido somente quando permitido pela ViewModel
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    onPressed: () {
                                      _showCompletionDialog(context);
                                    },
                                    child: Text(
                                      'Finalizar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _renderContent(String htmlContent) {
    return Html(
      data: htmlContent,
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Conteúdo Finalizado! Voltando para a trilha.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.apply(color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text('Trilha',
                      style: Theme.of(context).textTheme.bodyLarge?.apply(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
