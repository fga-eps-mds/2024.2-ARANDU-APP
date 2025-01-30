import 'package:aranduapp/ui/access_trails/view/flecha.dart';
import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AccessTrails extends StatelessWidget {
  final JourneyModel journey;

  const AccessTrails({super.key, required this.journey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccessTrailsViewmodel>.value(
      value: GetIt.instance<AccessTrailsViewmodel>(),
      child: _AccessTrailsScreen(journey: journey),
    );
  }
}

class _AccessTrailsScreen extends StatelessWidget {
  final JourneyModel journey;

  const _AccessTrailsScreen({required this.journey});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<AccessTrailsViewmodel>(context, listen: false);

    viewModel.getAccessTrailsCommand.execute(journey.id);

    return Scaffold(
        appBar: _buildAppBar(context),
        body: ListenableBuilder(
            listenable: viewModel.getAccessTrailsCommand,
            builder: (context, child) {
              if (viewModel.getAccessTrailsCommand.isOk)
                return CorpoList();
              else if (viewModel.getAccessTrailsCommand.isError)
                return ErrorScreen(
                    message:
                        "Dasdf \n ${viewModel.getAccessTrailsCommand.result!.asError!.error.toString()}");

              return Text("asdfasdf");
            }));
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
