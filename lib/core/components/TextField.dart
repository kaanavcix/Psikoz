import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/TextThemeConstants.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PsikozTextField extends StatelessWidget {
  PsikozTextField({
    Key? key,
    this.controller,
    this.text,
    this.icon,
    this.style,
    this.obsureIcon,
    this.obsureText,
    this.validator,
  }) : super(key: key);
  dynamic controller;
  dynamic text;
  var obsureText;
  dynamic obsureIcon;
  dynamic icon;
  dynamic style;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
      obscureText: obsureText??false,
      validator: validator,
      controller: controller,
      autocorrect: false,
      cursorColor: ColorPallete.PURPLECOLOR,
      decoration: InputDecoration(
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: ThemeConstant.textField)),
          suffixIcon: obsureIcon,
          prefixIcon: icon,
          hintStyle: Get.theme.textTheme.headline1,
          hintText: text,
          iconColor: ColorPallete.BLUECOLOR,
          prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: ThemeConstant.textFieldEnabeld)),
          enabled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color:ThemeConstant.textField),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ThemeConstant.textField),
          )),
    );
  }
}
