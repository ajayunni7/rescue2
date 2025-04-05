import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headlineLarge =
      GoogleFonts.afacad(fontSize: 32, fontWeight: FontWeight.bold);
  static TextStyle headlineLargeBlack = GoogleFonts.afacad(
      fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle headlineMedium = GoogleFonts.afacad(
      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle headlineMediumBlack = GoogleFonts.afacad(
      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle bodyLargeWhite = GoogleFonts.afacad(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle bodyLargeBlack = GoogleFonts.afacad(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle bodyMedium = GoogleFonts.afacad(fontSize: 12);
  static TextStyle bodyMediumWhite =
      GoogleFonts.afacad(fontSize: 12, color: Colors.white);
}

class ResponsiveHelper {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ResponsiveHelper(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  double width(double value) => screenWidth * value;
  double height(double value) => screenHeight * value;
  double fontSize(double value) => screenWidth * value;
}
