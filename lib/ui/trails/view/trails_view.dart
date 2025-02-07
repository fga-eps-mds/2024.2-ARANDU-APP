import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/content/view/content_view.dart';
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
        child: Center(
          child: Column(
            children: [
              CustomPaint(
                painter: Fundo(colors),
                child: const SizedBox(
                  height: 100,
                  width: 200,
                ),
              ),
              CustomPaint(
                painter: Square(colors),
                child: const SizedBox(
                  height: 100,
                  width: 200,
                ),
              ),
              CustomPaint(
                painter: Base(colors),
                child: const SizedBox(
                  height: 50,
                  width: 200,
                ),
              ),
              Container(
                color: colors.onInverseSurface,
                width: 100,
                child: Center(
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
          } else if (viewModel.getTrailsCommand.isError) {
            return ErrorScreen(
                message:
                    "Deslize para baixo\n\n ${viewModel.getTrailsCommand.result!.asError!.error.toString()}");
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
          title: Container(
            child: Center(
              child: FloatingActionButton(
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
                  }),
            ),
          ),
        );
      },
    );
  }
}
