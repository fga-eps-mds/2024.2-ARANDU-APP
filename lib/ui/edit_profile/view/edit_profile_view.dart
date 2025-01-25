import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/ui/edit_profile/model/edit_profile_request.dart';
import 'package:aranduapp/ui/edit_profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:aranduapp/ui/shared/text_email.dart';
import 'package:aranduapp/ui/shared/text_name.dart';
import 'package:aranduapp/ui/shared/command_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileViewModel>.value(
      value: GetIt.instance<EditProfileViewModel>(),
      child: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Center(
            child: Text(
              'Editar perfil',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
          ),
          leading: IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildForm(context, viewModel),
            ],
          ),
        ));
  }

  Widget _buildForm(BuildContext context, EditProfileViewModel viewModel) {
    viewModel.getUserCommand.execute();

    return ListenableBuilder(
        listenable: viewModel.getUserCommand,
        builder: (context, child) {
          UserModel? user = viewModel.getUserCommand.result?.asValue?.value;

          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextName(
                  key: const Key("nameController"),
                  controller: nameController,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  initialText: user?.name ?? "",
                ),
                const SizedBox(height: 20),
                TextName(
                  key: const Key("userNameController"),
                  label: "Nome de Usuário",
                  controller: userNameController,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                ),
                const SizedBox(height: 20),
                TextEmail(
                  key: const Key("emailNameController"),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  controller: emailController,
                  initialText: user?.email ?? "",
                ),
                const SizedBox(height: 100),
                _saveButton(context, viewModel),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget _saveButton(BuildContext context, EditProfileViewModel viewModel) {
    return CommandButton(
        tap: () {
          if (formKey.currentState!.validate()) {
            viewModel.editCommand.execute(EditProfileRequest(
                name: nameController.text,
                email: emailController.text,
                userName: userNameController.text));
          }
        },
        command: viewModel.editCommand,
        nameButton: "Salvar",
        onErrorCallback: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e)),
          );
        },
        onSuccessCallback: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario atualizado com sucesso. ')),
          );
        });
  }
}
