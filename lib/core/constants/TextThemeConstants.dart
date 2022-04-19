import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';
class TextThemeConstants{
  

static TextStyle NAMESTYLE = GoogleFonts.dancingScript(
    color: Get.isDarkMode? Colors.white:Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  
  static TextStyle BLUEPOPI =
      GoogleFonts.poppins(color: Colors.white);


}