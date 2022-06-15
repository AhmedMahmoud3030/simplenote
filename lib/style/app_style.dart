import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Color(0xffe2e2ff);
  static Color primaryColor = Color(0xFF0B1557);
  static Color secoundaryColor = Color(0xff0065ff);

  //card colors
  static List<Color> cardsColor = [
    
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.teal.shade100,
    Colors.amber.shade100,
    Colors.blueGrey.shade100,
  ];

  //text Style
  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainContent = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dateTitle = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.black54,
    fontWeight: FontWeight.w500,
  );
}
