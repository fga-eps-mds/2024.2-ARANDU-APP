import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';

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
                    Expanded(
                      child: SingleChildScrollView(
                        controller: viewModel.scrollController,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _renderMarkdown(content['content']),
                            // Botão "Finalizar" sempre visível no final
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
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

  Widget _renderMarkdown(String markdownContent) {
    return MarkdownBody(
      data: markdownContent,
      builders: {
        'latex': LatexElementBuilder(),
      },
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax()],
        [LatexInlineSyntax()],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Trilha',
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
