import 'package:aranduapp/ui/access_trails/model/access_trails_model.dart';
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
    return ChangeNotifierProvider<AccessTrailsViewmodel>(
      create: (_) => GetIt.instance<AccessTrailsViewmodel>(),
      child:  _AccessTrailsView(),
    );
  }
}


//////////return FutureBuilder(
//////////  future: viewModel.getTrails(),
//////////  builder: (context, snapshot) {
//////////    if (snapshot.connectionState == ConnectionState.waiting) {
//////////      return const Center(child: CircularProgressIndicator());
//////////    } else if (snapshot.hasError) {
//////////      return ErrorScreen(message: "adfasdfadf",);
//////////    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//////////      return const Center(child: Text('Nenhuma trilha encontrada.'));
//////////    }
//////////    return _buildListView(snapshot);
//////////  },
//////////);

class _AccessTrailsView extends StatelessWidget {

  final JourneyModel journey;

  const _AccessTrailsView({super.key, required this.journey});

  @override
  Widget build(BuildContext context) {

    AccessTrailsViewmodel viewModel = Provider.of<AccessTrailsViewmodel>(context);

  
    viewModel.trailsCommand.execute();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListenableBuilder(
      listenable: viewModel.trailsCommand,
        builder: (context, child) {

          if (viewModel.trailsCommand.isOk )
            return  Text("asdfsdf");
          else if ( viewModel.trailsCommand.isError)
            return ErrorScreen( message: "Dasdf \n ${viewModel.trailsCommand.result!.asError!.error.toString()}")
            
          return  Text("asdfasdf");

        }


      )

    );
  }

  ListView _buildListView(AsyncSnapshot<List<AccessTrailsModel>> snapshot) {
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
