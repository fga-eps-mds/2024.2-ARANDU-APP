import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSlogan extends StatelessWidget {
  const TitleSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 96,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            "Arandú",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: GoogleFonts.amarante().fontFamily ,
              fontSize: 64,
            ),
          ),
        ],
      ),
    );
  }
}
