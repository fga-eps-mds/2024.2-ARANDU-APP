import 'package:aranduapp/ui/content/view/content_view.dart';
import 'package:aranduapp/ui/pages_content/viewmodel/page_content_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class PagesContentView extends StatelessWidget {
  final List<String> listContent;

  const PagesContentView({super.key, required this.listContent});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageContentViewmodel>.value(
      value: GetIt.instance<PageContentViewmodel>(),
      child: PagesContentScreen(listContent: listContent),
    );
  }
}

class PagesContentScreen extends StatelessWidget {
  final List<String> listContent;

  final PageController _pageViewController = PageController();

  PagesContentScreen({super.key, required this.listContent});

  @override
  Widget build(BuildContext context) {
    PageContentViewmodel viewModel = Provider.of<PageContentViewmodel>(context);

    return Stack(
      children: [
        PageView(
            controller: _pageViewController,
            onPageChanged: (index) => viewModel.selectedIndex,
            children: List.generate(listContent.length, (index) {
              return ContentView(contentID: listContent[index]);
            })),
      ],
    );
  }
}
