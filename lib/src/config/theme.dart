import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeInfo {
  static const Color primary = Color.fromARGB(255, 217, 112, 112);
  static const Color background = Color(0xffF5F5F5);
  static const Color myGrey = Colors.grey;
  static const Color negroTexto = Color(0xff4E4E4E);

  static ThemeData getTheme() {
    return ThemeData(
      backgroundColor: background,
      primaryColor: primary,
      fontFamily: GoogleFonts.roboto().fontFamily,
    );
  }
}
