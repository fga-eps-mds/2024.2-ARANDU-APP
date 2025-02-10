import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/pages_content/view/pages_content_view.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:aranduapp/ui/trails/view/flecha.dart';
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

  _TrailsScreen({required this.journey});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              CustomPaint(
                painter: Fundo(colors),
                child: const SizedBox(
                  height: 250,
                  width: 200,
                ),
              ),
              CustomPaint(
                painter: Corpo(colors),
                child: SizedBox(
                  width: 100,
                  child: _buildTrails(context),
                ),
              ),
              CustomPaint(
                painter: Ponta(colors),
                child: const SizedBox(
                  height: 250,
                  width: 225,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      toolbarHeight: 60,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              journey.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
            ),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
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
          } else {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (viewModel.getTrailsCommand.isError)
                        ErrorScreen(
                          message:
                              "Deslize para baixo \n\n ${viewModel.getTrailsCommand.result!.asError!.error.toString()}",
                        )
                      else if (!viewModel.isReloadingData)
                        const LoadingWidget(),
                    ],
                  ),
                ),
              ),
            );
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
          minTileHeight: 300,
          title: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 5,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              if (trails.contects != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PagesContentView(
                      listContent: trails.contects ?? [],
                    ),
                  ),
                );
              }
            },
          ),
          subtitle: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: Text(trails.name),
                ),
                SizedBox(
                  child: Text(trails.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
