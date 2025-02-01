import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:aranduapp/ui/trails/viewmodel/trails_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Trails extends StatelessWidget {
  final JourneyModel journey;

  const Trails({super.key, required this.journey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TrailsViewmodel>.value(
      value: GetIt.instance<TrailsViewmodel>(),
      child: _TrailsScreen(journey: journey),
    );
  }
}

class _TrailsScreen extends StatelessWidget {
  final JourneyModel journey;

  const _TrailsScreen({required this.journey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildTrails(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      scrolledUnderElevation: 0,
      title: Text(
        'Lógica Booleana',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildTrails(BuildContext context) {
    TrailsViewmodel viewModel = Provider.of<TrailsViewmodel>(context);

    viewModel.getTrailsCommand.execute(journey.id);

    return RefreshIndicator(
      onRefresh: () => viewModel.getTrailsCommand.execute(journey.id),
      child: ListenableBuilder(
        listenable: viewModel.getTrailsCommand,
        builder: (context, child) {
          if (viewModel.getTrailsCommand.isOk) {
            return _buildListView(context);
          } else if (viewModel.getTrailsCommand.isError) {
            return ErrorScreen(message: "Deslize para baixo\n\n ${viewModel.getTrailsCommand.result!.asError!.error.toString()}");
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  ListView _buildListView(BuildContext context) {

    TrailsViewmodel viewModel = Provider.of<TrailsViewmodel>(context);

    return ListView.builder(
        itemCount: viewModel.getTrailsCommand.result!.asValue!.value.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var trails = viewModel.getTrailsCommand.result!.asValue!.value[index];
          return ListTile(
            leading: Icon(
              Icons.collections_bookmark_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            title: Text(trails.name?? "NULL"),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            onTap: () {
              Log.d("tap");
            },
          );
        });
  }
}
