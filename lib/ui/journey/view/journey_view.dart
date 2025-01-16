import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Journey extends StatelessWidget {
  const Journey({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JourneyViewModel>.value(
      value: GetIt.instance<JourneyViewModel>(),
      child: const JourneyScreen(),
    );
  }
}

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildPage(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      scrolledUnderElevation: 0,
      title: Text(
        'Jornadas de Lógica',
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

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildJourney(context),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildJourney(BuildContext context) {
    JourneyViewModel viewModel = Provider.of<JourneyViewModel>(context);

    return Card(
      child: Column(
        children: [
          RefreshIndicator(
            onRefresh:  viewModel.journeyCommand.execute,
            child: ListenableBuilder(
              listenable: viewModel.journeyCommand,
              builder: (context, child) {
                if (viewModel.journeyCommand.isOk) {
                  return ListView.builder(
                      itemCount: viewModel.journeyCommand.result!.asValue!.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var journey = viewModel.journeyCommand.result!.asValue!.value[index];
                        return ListTile(
                          leading: Icon(
                            Icons.border_right,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                          title: Text(journey.title),
                          subtitle: Text(journey.description),
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
                } else if (viewModel.journeyCommand.isError) {
                  return const ErrorScreen(message: "Deslize para baixo");
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
