import 'package:aranduapp/ui/profile/viewModel/ProfileViewModel.dart';
import 'package:aranduapp/ui/shared/ProfileHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // AppBar construído aqui
      body: ChangeNotifierProvider(
        create: (context) => ProfileViewModel(context),
        builder: (context, child) {
          return _buildPage(context); // Página principal
        },
      ),
    );
  }

  /// Constrói o AppBar
  AppBar _buildAppBar() {
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

  /// Constrói a Página Principal
  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(), // Cabeçalho do perfil
          const SizedBox(height: 16),
          _buildProfileContent(), // Conteúdo adicional
        ],
      ),
    );
  }

  /// Widget do Cabeçalho do Perfil
  Widget _buildProfileHeader() {
    return ProfileHeader(
      name: "Stefani",
      role: "Estudante",
      onEditPressed: null, // Botão sem ação no momento
    );
  }

  /// Widget do Conteúdo Adicional
  Widget _buildProfileContent() {
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
