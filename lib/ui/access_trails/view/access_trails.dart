import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'flecha.dart';

class AccessTrails extends StatelessWidget {
  final JourneyModel journey;

  const AccessTrails(this.journey);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccessTrailsViewmodel>.value(
      value: GetIt.instance<AccessTrailsViewmodel>(),
      child: _AccessTrails(),
    );
  }
}

class _AccessTrails extends StatelessWidget {
  const _AccessTrails();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomPaint(
                  painter: Fundo(),
                  child: const SizedBox(
                    height: 100,
                    width: 200,
                  ),
                ),
                CustomPaint(
                  painter: Square(),
                  child: const SizedBox(
                    height: 100,
                    width: 200,
                  ),
                ),
                CustomPaint(
                  painter: Base(),
                  child: const SizedBox(
                    height: 50,
                    width: 200,
                  ),
                ),
                const CorpoList(), // Agora os itens da lista são botões!
                CustomPaint(
                  painter: Ponta(),
                  child: const SizedBox(
                    height: 250,
                    width: 225,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Center(
        child: Text(
          'Lógica Booleana',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24,
          ),
        ),
      ),
      leading: IconButton(
        color: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
