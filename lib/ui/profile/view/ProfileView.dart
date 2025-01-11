import 'package:aranduapp/ui/edit_password/view/edit_password_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
import 'package:aranduapp/ui/edit_profile/view/edit_profile_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context),
        builder: (context, child) {
          return _buildPage(context);
        },
      ),
    );
  }

  /// AppBar
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
          child: Container(
            child: Center(
              child: Icon(
                Icons.notifications_none_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
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
          ],
        ),
      ),
    );
  }

  /// Cabeçalho do Perfil
  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileHeader(
          name: "Stefani",
          role: "Estudante",
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
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
    return Card(
      child: Column(
        children: [
          ListTile(
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
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.logout_sharp,
              color: Theme.of(context).colorScheme.error,
              size: 32,
            ),
            title: const Text('Sair'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
