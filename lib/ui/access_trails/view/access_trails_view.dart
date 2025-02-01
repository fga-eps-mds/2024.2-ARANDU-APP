import 'package:aranduapp/ui/access_trails/view/flecha.dart';
import 'package:aranduapp/ui/access_trails/viewmodel/access_trails_viewmodel.dart';
//import 'package:aranduapp/ui/content/service/content_service.dart';
import 'package:aranduapp/ui/journey/model/journey_model.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
//import 'grafismo.dart';

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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildTrails(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      /*flexibleSpace: CustomPaint(
        size: Size(double.infinity, kToolbarHeight),
        painter: CustomPatternPainter(colors),
      ),*/
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
              'Lógica booleana',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildTrails(BuildContext context) {
    AccessTrailsViewmodel viewModel =
        Provider.of<AccessTrailsViewmodel>(context);

    viewModel.getAccessTrailsCommand.execute(journey.id);

    return ListenableBuilder(
      listenable: viewModel.getAccessTrailsCommand,
      builder: (context, child) {
        if (viewModel.getAccessTrailsCommand.isOk) {
          return _buildListView(context);
        } else if (viewModel.getAccessTrailsCommand.isError) {
          return ErrorScreen(
              message:
                  "Não foi possível carregar trilha \n ${viewModel.getAccessTrailsCommand.result!.asError!.error.toString()}");
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
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
              CorpoList(colors: colors),
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
}
