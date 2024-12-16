import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:aranduapp/ui/shared/ProfileSection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 16),
          _buildProfileContent(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return ProfileHeader(
      name: "Stefani",
      role: "Estudante",
      onEditPressed: () {
        print('Editar perfil');
      },
    );
  }

  /// Conteúdo do Perfil com Seções
  Widget _buildProfileContent(BuildContext context) {
    return Column(
      children: [
        // Seção 1: Conta
        ProfileSection(
          title: 'Conta',
          children: const [
            ProfileItem(
              icon: Icons.person_outline,
              text: 'Dados Pessoais',
            ),
            ProfileItem(
              icon: Icons.emoji_events_outlined,
              text: 'Conquistas',
            ),
            ProfileItem(
              icon: Icons.history,
              text: 'Histórico',
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Seção 2: Notificações
        ProfileSection(
          title: 'Notificações',
          children: [
            ProfileItem(
              icon: Icons.notifications_none_outlined,
              text: 'Notificação Pop-up',
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Ação do Switch (placeholder)
                  print('Notificação Pop-up: $value');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Seção 3: Outros
        ProfileSection(
          title: 'Outros',
          children: const [
            ProfileItem(
              icon: Icons.email_outlined,
              text: 'Contate-nos',
            ),
            ProfileItem(
              icon: Icons.privacy_tip_outlined,
              text: 'Política de Privacidade',
            ),
            ProfileItem(
              icon: Icons.settings_outlined,
              text: 'Configurações',
            ),
          ],
        ),
      ],
    );
  }
}
