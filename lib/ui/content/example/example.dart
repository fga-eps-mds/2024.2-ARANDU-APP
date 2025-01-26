import 'package:aranduapp/ui/content/view/content_view.dart';
import 'package:flutter/material.dart';
import 'package:aranduapp/ui/content/service/content_service.dart';

class Example extends StatefulWidget {
  final String trailID;

  const Example({super.key, required this.trailID});

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final ContentService _contentService = ContentService();
  late Future<List<Map<String, dynamic>>?> _contentsFuture;

  @override
  void initState() {
    super.initState();
    _contentsFuture = _contentService.getContentsByTrail(widget.trailID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Conteúdos",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: _contentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar conteúdos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum conteúdo encontrado"));
          }

          final contents = snapshot.data!;
          return ListView.builder(
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final content = contents[index];
              return ListTile(
                title: Text(content['title']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContentView(contentID: content['_id']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
