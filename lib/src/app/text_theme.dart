import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemesPokedex {
  ThemesPokedex._();

  static TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.bold,
  
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.bold,
    
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w600,
  
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w600,
  
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: .53,
  
    ),
  );
}
