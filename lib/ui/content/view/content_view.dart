import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';

class ContentView extends StatelessWidget {
  final String contentID;

  const ContentView({super.key, required this.contentID});

  @override
  Widget build(BuildContext context) {
    final viewModel = GetIt.instance<ContentViewModel>();
    viewModel.contentCommand.execute(contentID);
    return ChangeNotifierProvider<ContentViewModel>.value(
      value: viewModel,
      child: const ContentScreen(),
    );
  }
}

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: _buildAppBarTitle(context),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildAppBarTitle(BuildContext context) {
    ContentViewModel viewModel = Provider.of<ContentViewModel>(context);

    return ListenableBuilder(
      listenable: viewModel.contentCommand,
      builder: (context, child) {
        if (viewModel.contentCommand.running) {
          return const Text("Carregando...");
        } else if (viewModel.contentCommand.isError) {
          return const Text("Erro");
        } else if (viewModel.content == null) {
          return const Text("Conteúdo não encontrado");
        }
        return Text(viewModel.content!.title);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final viewModel = Provider.of<ContentViewModel>(context);

    return ListenableBuilder(
      listenable: viewModel.contentCommand,
      builder: (context, child) {
        if (viewModel.contentCommand.running) {
          return const LoadingWidget();
        } else if (viewModel.contentCommand.isError) {
          return Center(
              child: Text(
                  viewModel.contentCommand.result!.asError!.error.toString()));
        } else if (viewModel.content == null) {
          return const ErrorScreen(message: "Conteúdo não encontrado.");
        }

        return Column(
          children: [
            _buildProgressBar(context),
            _buildContent(context),
          ],
        );
      },
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    final viewModel = Provider.of<ContentViewModel>(context, listen: true);
    return SizedBox(
      height: 10.0,
      child: LinearProgressIndicator(
        value: viewModel.progress,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final viewModel = Provider.of<ContentViewModel>(context, listen: true);
    final content = viewModel.content!;

    return Expanded(
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
              _renderMarkdown(content.content),
              if (viewModel.shouldShowButton) _buildCompletionButton(context),
            ],
          ),
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

  Widget _buildCompletionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => _showCompletionDialog(context),
        child: Text(
          'Finalizar',
          style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
