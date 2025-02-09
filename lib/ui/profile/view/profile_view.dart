import 'package:aranduapp/core/network/token_manager/model/user_model.dart';
import 'package:aranduapp/ui/edit_delete_user/view/edit_delete_user_view.dart';
import 'package:aranduapp/ui/edit_password/view/edit_password_view.dart';
import 'package:aranduapp/ui/login/view/login_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:aranduapp/ui/shared/profile_header.dart';
import 'package:aranduapp/ui/profile/viewmodel/profile_viewmodel.dart';
import 'package:aranduapp/ui/edit_profile/view/edit_profile_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ChangeNotifierProvider.value(
        value: GetIt.I<ProfileViewModel>(),
        builder: (context, child) {
          return _buildPage(context);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      scrolledUnderElevation: 0,
      title: Text(
        'Perfil',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
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

  /// Página principal
  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 80),
            _setting(context),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  /// Cabeçalho do Perfil
  Widget _buildProfileHeader(BuildContext context) {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);

    viewModel.getUserCommand.execute();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListenableBuilder(
            listenable: viewModel.getUserCommand,
            builder: (context, child) {
              UserModel? user = viewModel.getUserCommand.result?.asValue?.value;

              return ProfileHeader(
                name: user?.name == null ? "..." : user!.name,
                role: user?.role == null ? "..." : user!.role,
              );
            }),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              ).then((result) {
                viewModel.getUserCommand.execute();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 2,
            ),
            child: Text(
              "Editar",
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _setting(BuildContext context) {
    ProfileViewModel viewModel = Provider.of<ProfileViewModel>(context);

    return Card(
      child: Column(
        children: [
          _editPassword(context),
          const Divider(),
          _deleteAccount(context),
          const Divider(),
          _logout(viewModel),
        ],
      ),
    );
  }

  ListTile _editPassword(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.lock_reset,
        color: Theme.of(context).colorScheme.primary,
        size: 32,
      ),
      title: const Text('Trocar senha'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.primary,
        size: 32,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditPassword(),
          ),
        );
      },
    );
  }

  ListTile _deleteAccount(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.delete_forever,
        color: Theme.of(context).colorScheme.error,
        size: 32,
      ),
      title: const Text('Apagar conta'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.error,
        size: 32,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditDeleteUser(),
          ),
        );
      },
    );
  }

  ListenableBuilder _logout(ProfileViewModel viewModel) {
    return ListenableBuilder(
      listenable: viewModel.logoutCommand,
      builder: (context, child) {
        if (viewModel.logoutCommand.isOk) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          });
        }

        return ListTile(
          key: const Key('logout_button'),
          leading: Icon(
            Icons.logout_sharp,
            color: Theme.of(context).colorScheme.error,
            size: 32,
          ),
          title: const Text('Sair'),
          onTap: viewModel.logoutCommand.execute,
        );
      },
    );
  }
}
