import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback? onEditPressed;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.role,
    this.onEditPressed, // Botão pode não ter ação inicialmente
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Imagem circular + texto
          Row(
            children: [
              // Imagem circular
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E1E1), // Cor cinza claro
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              // Nome e descrição
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Botão Editar
          ElevatedButton(
            onPressed: onEditPressed ?? () {}, // Não faz nada se nulo
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD1410A), // Cor do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 2,
            ),
            child: const Text(
              "Editar",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
