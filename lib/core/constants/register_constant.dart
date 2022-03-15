// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class Register_Constants {
  static String REGISTER_TEXT = "Kayıt Ol";
  static String MAIL_TEXT = "Mail";
  static String PASSWORD_TEXT = "Password";
  static String USERNAME_TEXT = "Username";
  static String REGISTER_BUTTON_TEXT = REGISTER_TEXT.toUpperCase();
  static String PASSWORD_AGAIN_TEXT = "Password(Again)";

  static BoxDecoration BOXDECORATION = BoxDecoration(
      boxShadow: const [BoxShadow(color: Colors.white,blurRadius: 0.7, spreadRadius: 0.4)],
      /* image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(Login_Constants.CONTAINER_BACKGROUND)), */
      color: Colors.white,
      borderRadius: BorderRadius.circular(44));
}
