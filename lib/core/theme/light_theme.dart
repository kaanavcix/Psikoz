import 'package:flutter/material.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';

ThemeData lightTheme =ThemeData(
  brightness: Brightness.light,
  
  backgroundColor: AppColor.bodyColor,
  scaffoldBackgroundColor: AppColor.bodyColor,
  hintColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.black,),
  disabledColor: Colors.black,
  primaryIconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle:TextStyle(color: Colors.black)
  ),
  canvasColor: Colors.white,
  appBarTheme: AppBarTheme(color: Colors.white),
  primaryColor: AppColor.buttonBackgroundColor,
  textTheme: const TextTheme(headline1: TextStyle(
    color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold,
  ),headline5: TextStyle(color: Colors.black)),
  buttonTheme: const ButtonThemeData()
  
  

);