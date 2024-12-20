// MVVM
import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
// Componentes
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
//import 'package:aranduapp/ui/shared/ProfileSection.dart';
// Bibliotecas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Paginas
import 'package:aranduapp/ui/edit_profile/view/EditProfileView.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 80),
          _buildLogoutButton(
            context,
            () {
              // Lógica de logout
              print('Usuário deslogado!');
            },
          ),
        ],
      ),
    );
  }

  /// Cabeçalho do Perfil
  Widget _buildProfileHeader(BuildContext context) {
    return ProfileHeader(
      name: "Stefani",
      role: "Estudante",
      onEditPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfile()),
        );
      },
    );
  }

  /// Botão Deslogar
  Widget _buildLogoutButton(BuildContext context, VoidCallback onPressed) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bordas arredondadas
            ),
            elevation: 6,
          ),
          child: const Text('Deslogar'),
        ),
      ),
    );
  }
}
