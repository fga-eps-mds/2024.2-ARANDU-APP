// MVVM
import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
// Componentes
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:aranduapp/ui/shared/ProfileSection.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ),
      title: Text(
        'Perfil',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
            ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
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
          const SizedBox(height: 16),
          _buildProfileSection(context), // Chama as seções
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

  /// Seções do Perfil
  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        // Seção "Conta"
        ProfileSection(
          title: 'Conta',
          items: [
            ProfileLinkItem(
              icon: Icons.person_outline,
              name: 'Dados Pessoais',
              onTap: () {
                print("Dados Pessoais");
              },
            ),
            ProfileLinkItem(
              icon: Icons.emoji_events_outlined,
              name: 'Conquistas',
              onTap: () {
                print("Conquistas");
              },
            ),
            ProfileLinkItem(
              icon: Icons.history_outlined,
              name: 'Histórico',
              onTap: () {
                print("Histórico");
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Seção "Notificações"
        ProfileSection(
          title: 'Notificações',
          items: [
            ProfileLinkItem(
              icon: Icons.notifications_none_outlined,
              name: 'Notificação Pop-up',
              hasSwitch: true,
              switchValue: true,
              onSwitchChanged: (value) {
                print("Switch Notificação: $value");
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Seção "Outros"
        ProfileSection(
          title: 'Outros',
          items: [
            ProfileLinkItem(
              icon: Icons.email_outlined,
              name: 'Contate-nos',
            ),
            ProfileLinkItem(
              icon: Icons.privacy_tip_outlined,
              name: 'Política de Privacidade',
            ),
            ProfileLinkItem(
              icon: Icons.settings_outlined,
              name: 'Configurações',
            ),
          ],
        ),
      ],
    );
  }
}
