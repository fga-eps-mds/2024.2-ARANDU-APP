import 'package:aranduapp/ui/join_subjects/viewmodel/join_subjects_viewmodel.dart';
import 'package:aranduapp/ui/journey/view/journey_view.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:aranduapp/ui/subjects/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class JoinSubjects extends StatelessWidget {
  final SubjectModel subject;
  const JoinSubjects({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JoinSubjectsViewmodel>.value(
      value: GetIt.instance<JoinSubjectsViewmodel>(),
      child: _JoinSubjectsScreen(subject: subject),
    );
  }
}

class _JoinSubjectsScreen extends StatelessWidget {
  final SubjectModel subject;
  const _JoinSubjectsScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JoinSubjectsViewmodel>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildJoinSubjects(context, viewModel, subject),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Text(
        subject.name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        color: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Icon(
              Icons.notifications_none_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJoinSubjects(BuildContext context,
      JoinSubjectsViewmodel viewModel, SubjectModel subject) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              top: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                Row(children: [
                  Icon(
                    Icons.book,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 120,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Flexible(
                      child: Text(
                    subject.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    softWrap: true,
                  )),
                ]),
                SizedBox(height: screenHeight * 0.06),
                Text(
                  subject.description,
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: screenHeight * 0.05),
        child: Center(
          child: _joinButton(context, viewModel),
        ),
      ),
    ]);
  }

  Widget _joinButton(BuildContext context, JoinSubjectsViewmodel viewModel) {
    return CommandButton(
      tap: () {
        viewModel.joinsubjectsCommand.execute(subject.id);
      },
      command: viewModel.joinsubjectsCommand,
      nameButton: "Ingressar",
      onErrorCallback: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      },
      onSuccessCallback: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Journey(subject: subject)),
        );
      },
    );
  }
}
