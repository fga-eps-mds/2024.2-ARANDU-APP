import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:aranduapp/ui/home/view/home_view.dart';

class ContentView extends StatelessWidget {
  final String contentID;

  const ContentView({super.key, required this.contentID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentViewModel()..fetchContent(contentID),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ContentViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Text("Carregando...");
              } else if (viewModel.error != null) {
                return const Text("Erro");
              } else if (viewModel.content == null) {
                return const Text("Conteúdo não encontrado");
              }
              return Text(viewModel.content!.title);
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: Consumer<ContentViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.error != null) {
              return Center(child: Text(viewModel.error!));
            } else if (viewModel.content == null) {
              return const Center(child: Text("Conteúdo não encontrado"));
            }

            final content = viewModel.content!;

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
                // Conteúdo rolável
                Expanded(
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _renderMarkdown(
                              content.content), // Renderiza Markdown
                          if (viewModel.shouldShowButton) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () => _showCompletionDialog(context),
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
        ),
      ),
    );
  }

  // Método para renderizar Markdown
  Widget _renderMarkdown(String markdownContent) {
    return MarkdownBody(
      data: markdownContent,
      builders: {
        'latex': LatexElementBuilder(), // Suporte a LaTeX
      },
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax()], // Suporte a blocos LaTeX
        [LatexInlineSyntax()], // Suporte a LaTeX inline
      ),
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (Route<dynamic> route) => false,
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
            ),
          ),
        );
      },
    );
  }
}
