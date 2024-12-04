import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.role,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 30, // Tamanho do avatar
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 12), // Espaçamento entre avatar e texto
        // Nome e função
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4), // Espaçamento entre nome e função
            Text(
              role,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
