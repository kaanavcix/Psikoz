import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';
class ThemeConstant {
  static dynamic textField = Get.isDarkMode ? Colors.white : Colors.black;
  static dynamic textFieldEnabeld = Get.isDarkMode ? Colors.white : Colors.grey;
  static dynamic mode = Get.isDarkMode ? AppColor.bodyColor:Colors.white;
    static dynamic logoMode = Get.isDarkMode ? Colors.black : Colors.white;
}
