import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AccessTrails extends StatelessWidget {
  const AccessTrails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccessTrailsViewmodel>(
      create: (_) => GetIt.instance<AccessTrailsViewmodel>(),  // Use create em vez de value
      child: const _AccessTrailsView(),
    );
  }
}

class _AccessTrailsView extends StatelessWidget {
  const _AccessTrailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer<AccessTrailsViewmodel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.getTrails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar trilhas: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhuma trilha encontrada.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final trail = snapshot.data![index];
                  return ListTile(
                    title: Text(trail.title),
                    subtitle: Text(trail.description),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Lógica Booleana'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
