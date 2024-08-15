import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.pressStart2pTextTheme(
    ThemeData.light().textTheme,
  ),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFEEEEEE),
    primary: Colors.blueGrey,
    secondary: Color(0xFF212121),
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.pressStart2pTextTheme(
    ThemeData.dark().textTheme,
  ),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF212121),
    primary: Colors.blueGrey,
    secondary: Color(0xFFEEEEEE),
  ),
);
