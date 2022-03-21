// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_Constants {
  static String ERROR_MESSAGE_EMAIL = "Lütfen Tekrar Giriniz";
  static String LOGIN_TEXT = "Giriş Yap";
  static String MAIL_TEXT = "E-Mail";
  static String PASSWORD_TEXT = "Password";
  static String FORGET_PASSWORD_TEXT = " Şifrenizi mi Unuttunuz ?";
  static String LOGIN_BUTTON_TEXT = LOGIN_TEXT.toUpperCase();
  static String OR_LOGIN_WITH_TEXT = "Onlarla giriş yap";
  static String KULLANICI_OLUSTURMA_TEXT = "Bir hesaba sahip değilmisiniz";
  static String SIGN_UP_TEXT = " Sign Up";
  static String LOGO_IMAGE = "assets/images/logo.png";
  static String CONTAINER_BACKGROUND = "assets/images/register_image.png";
  static String LOGO_IMAGE2_SVG = "assets/images/logo_svg.svg";
  static String GOOGLE_LOGO = "assets/images/google_icon.png";
  static String APPLE_LOGO = "assets/images/apple_icon.png";
  static String DAILYLOGO = "assets/images/daily-report.svg";

  static TextStyle NUNITOTEXT_STYLE = GoogleFonts.nunito(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600));
  static TextStyle NUNITOTEXT_STYLE_BOLD = GoogleFonts.nunito(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800));
  static TextStyle NUNITOTEXT_JUST_TEXTSIZE =
      GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 12));
  static TextStyle NUNITOTEXT_STYLE_W700 = GoogleFonts.nunito(
      textStyle: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white));
static TextStyle POPPINS_STYLE = GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600));
  static BoxDecoration BOXDECORATION = BoxDecoration(
      boxShadow: const [
        BoxShadow(blurRadius: 1, spreadRadius: 0.4, color: Colors.white)
      ],
      /* image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(Login_Constants.CONTAINER_BACKGROUND)), */
      color: Colors.white,
      borderRadius: BorderRadius.circular(44));
}
