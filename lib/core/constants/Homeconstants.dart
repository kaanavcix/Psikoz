// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeConstant {
  static String APP_NAME = "Psikoz";
  static TextStyle NAMESTYLE = GoogleFonts.dancingScript(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static Color DIVIDERCOLOR = Color.fromRGBO(122, 143, 166, 1.0);

  static TextStyle BLUEPOPI =
      GoogleFonts.poppins(color: DIVIDERCOLOR);

  static String TREND = "Trend";
}
