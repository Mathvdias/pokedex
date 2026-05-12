import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemesPokedex {
  ThemesPokedex._();

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600),
    bodyLarge: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: .53,
    ),
  );
}
