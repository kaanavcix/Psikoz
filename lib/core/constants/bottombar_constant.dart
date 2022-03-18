// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class BottomBar_Constant {
  static int BOTTOM_HEIGHT = 55;
  static Color BOTTOM_BACKGROUND = const Color.fromRGBO(
    250,
    250,
    250,
    100,
  );
  static Color COLORGREENKA = const Color.fromRGBO(65, 149, 113, 1.0);
  static Color COLORBLUEKA = const Color.fromRGBO(74, 105, 255, 1.0);
  static List<Color> LINEARGRADIENT_COLOR = [COLORGREENKA, COLORBLUEKA];
  static ShapeBorder BOTTOMSHAPEBORDER = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
  );
}
