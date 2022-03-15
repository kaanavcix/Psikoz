// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileConstants {
  static String USERNAME = "PsikoExpa";
  static String SETTINGS_TEXT = "Settings";

  static TextStyle NUNITOTEXT_STYLE_W700_BLACK = GoogleFonts.nunito(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black));

  static TextStyle textStyle = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600));
  static TextStyle BUTTONSTYLE = GoogleFonts.nunito(
      textStyle: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white));
}
