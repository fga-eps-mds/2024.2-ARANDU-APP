//import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/journey/viewmodel/journey_viewmodel.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:aranduapp/ui/trails/view/trails_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Journey extends StatelessWidget {
  final SubjectModel subject;

  const Journey({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JourneyViewModel>.value(
      value: GetIt.instance<JourneyViewModel>(),
      child: _JourneyScreen(subject: subject),
    );
  }
}

class _JourneyScreen extends StatelessWidget {
  final SubjectModel subject;

  const _JourneyScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildJourney(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      scrolledUnderElevation: 0,
      title: Text(
        'Jornadas de ${subject.name}',
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

  Widget _buildJourney(BuildContext context) {
    JourneyViewModel viewModel = Provider.of<JourneyViewModel>(context);

    viewModel.getJourneyCommand.execute(subject.id);

    return RefreshIndicator(
      onRefresh: () => viewModel.getJourneyCommand.execute(subject.id),
      child: ListenableBuilder(
        listenable: viewModel.getJourneyCommand,
        builder: (context, child) {
          if (viewModel.getJourneyCommand.isOk) {
            return _buildListView(context);
          } else if (viewModel.getJourneyCommand.isError) {
            return ErrorScreen(message: "Deslize para baixo\n\n ${viewModel.getJourneyCommand.result!.asError!.error.toString()}");
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  ListView _buildListView(BuildContext context) {

    JourneyViewModel viewModel = Provider.of<JourneyViewModel>(context);

    return ListView.builder(
        itemCount: viewModel.getJourneyCommand.result!.asValue!.value.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var journey = viewModel.getJourneyCommand.result!.asValue!.value[index];
          return ListTile(
            leading: Icon(
              Icons.border_right,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            title: Text(journey.title),
            subtitle: Text(journey.description?? "Sem descrição"),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Trails(journey: journey),
              ),
            );
            },
          );
        });
  }
}
