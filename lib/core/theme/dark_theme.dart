import 'package:flutter/material.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.bodyColorDark,
    backgroundColor: AppColor.buttonBackgroundColorDark,
    hintColor: AppColor.textColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.bodyColorDark,),
    primaryColorDark: AppColor.buttonBackgroundColorDark,
    textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold),headline5: TextStyle(fontSize: 12,color: Colors.black)),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.black,

    ));
