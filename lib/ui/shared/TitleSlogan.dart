import 'package:flutter/material.dart';

class TitleSlogan extends StatelessWidget {
  const TitleSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 196,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const Text(
            "Arandú",
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
            ),
          ),
        ],
      ),
    );
  }
}
