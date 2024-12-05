import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSlogan extends StatelessWidget {
  const TitleSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    // Verifica se o tema atual é claro ou escuro
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 196,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              // Se for escuro, aplica um gradiente. Caso contrário, usa uma cor sólida.
              color: isDarkMode ? null : const Color(0xfffdba74),
              gradient: isDarkMode
                  ? const LinearGradient(
                      colors: [
                        Color(0xfffdba74),
                        Color(0xffc2410c)
                      ], // Gradiente de cor no modo escuro
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            "Arandú",
            style: GoogleFonts.amarante(
              // A cor do texto muda dependendo do modo de tema
              color: isDarkMode
                  ? Colors.white
                  : Colors.black, // Branco no modo escuro, preto no modo claro
              fontSize: 63,
            ),
          ),
        ],
      ),
    );
  }
}
