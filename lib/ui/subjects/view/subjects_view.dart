import 'package:aranduapp/core/log/log.dart';
import 'package:aranduapp/ui/subjects/viewmodel/subjects_viewmodel.dart';
import 'package:aranduapp/ui/shared/erro_screen.dart';
import 'package:aranduapp/ui/shared/loading_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Subject extends StatelessWidget {
  const Subject({super.key, required String title, required String description});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubjectsViewmodel>.value(
      value: GetIt.instance<SubjectsViewmodel>(),
      child: const SubjectScreen(),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildSubjects(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      scrolledUnderElevation: 0,
      title: Text(
        'Disciplinas',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildSubjects(BuildContext context) {
    SubjectsViewmodel viewModel = Provider.of<SubjectsViewmodel>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: viewModel.subjectCommand.execute,
      child: ListenableBuilder(
        listenable: viewModel.subjectCommand,
        builder: (context, child) {
          if (viewModel.subjectCommand.isOk) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                itemCount:
                    viewModel.subjectCommand.result!.asValue!.value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var subject =
                      viewModel.subjectCommand.result!.asValue!.value[index];
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(screenHeight * 0.02),
                        tileColor:
                            Theme.of(context).colorScheme.onInverseSurface,
                        leading: Container(
                          width: 72,
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.book,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 64,
                          ),
                        ),
                        title: Text(subject.title),
                        subtitle: Text(subject.description),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 56,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () {
                          Log.d("tap");
                        },
                      ),
                      SizedBox(
                          height: screenHeight * 0.01), // Espaço entre os itens
                    ],
                  );
                });
          } else if (viewModel.subjectCommand.isError) {
            return const ErrorScreen(message: "Deslize para baixo");
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
