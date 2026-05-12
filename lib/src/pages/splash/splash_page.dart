import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/app/text_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokedexColors.cream,
      body: Stack(
        children: [
          // Red top half
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(color: PokedexColors.red),
          ),
          // Black divider line
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 - 6,
            left: 0,
            right: 0,
            height: 12,
            child: Container(color: Colors.black),
          ),
          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/pokeball.png', width: 140, height: 140),
                const SizedBox(height: 32),
                Text(
                  'POKÉDEX',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 20,
                    color: PokedexColors.dark,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'by Matheus',
                  style: GoogleFonts.vt323(
                    fontSize: 22,
                    color: Colors.black54,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
