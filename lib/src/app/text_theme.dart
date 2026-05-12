import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokedexColors {
  static const red = Color(0xFFE3350D);
  static const yellow = Color(0xFFFFD700);
  static const cream = Color(0xFFFFF8E1);
  static const dark = Color(0xFF1A1A2E);
  static const pixelBorder = Colors.black;
}

class ThemesPokedex {
  ThemesPokedex._();

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.pressStart2p(fontSize: 18, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.pressStart2p(fontSize: 14, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.pressStart2p(fontSize: 11, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.pressStart2p(fontSize: 10, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.pressStart2p(fontSize: 9, fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.pressStart2p(fontSize: 13, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.vt323(fontSize: 22, letterSpacing: 0.5),
    bodyLarge: GoogleFonts.vt323(fontSize: 20),
    bodyMedium: GoogleFonts.vt323(fontSize: 18),
  );
}
