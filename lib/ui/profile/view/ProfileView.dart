import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(), // Widget de AppBar separado
      body: ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context),
        builder: (context, child) {
          return _buildPage(context); // Constrói a página principal
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderSection(), // Widget para o cabeçalho do perfil
          const SizedBox(height: 16),
          ProfileContent(), // Widget para o conteúdo da página
        ],
      ),
    );
  }
}

/// 1. Widget para o AppBar
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ),
      title: const Text(
        'Perfil',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
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
}

/// 2. Widget para o Cabeçalho do Perfil
class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileHeader(
      name: "Stefani",
      role: "Estudante",
      onEditPressed: null, // Botão sem ação no momento
    );
  }
}

/// 3. Widget para o Conteúdo da Página
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Conteúdo da tela de perfil...",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
    );
  }
}
