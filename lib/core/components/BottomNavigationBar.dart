// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/BorderConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/TextThemeConstants.dart';

class SnakeBottomNavigationBar extends StatelessWidget {
  SnakeBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  int selectedIndex;
  void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.gradient(
      shadowColor: ThemeConstant.mode,
      backgroundGradient:
          const LinearGradient(colors: [Color.fromARGB(255, 0, 0, 0), Colors.black]),
      snakeViewGradient: LinearGradient(
          colors: [ColorPallete.BLUECOLOR, ColorPallete.PURPLECOLOR]),
      //BottomBar_Constant.LINEARGRADIENT_COLOR
      selectedItemGradient:
          const LinearGradient(colors: [Colors.white, Colors.white]),
      unselectedItemGradient:
          LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade500]),
      behaviour: SnakeBarBehaviour.floating,
      //shape: BorderConstant.BOTTOMSHAPEBORDER,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: selectedIndex,
      onTap: onTap,
     // padding: EdgeInsets.all(2),
      snakeShape: SnakeShape.circle,
      items: const [
        BottomNavigationBarItem(icon: Icon(MfgLabs.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(
              Iconic.chat_inv,
              size: 24,
            ),
            label: 'chat'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
            label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(MfgLabs.search), label: 'microphone'),
        BottomNavigationBarItem(icon: Icon(Typicons.user), label: 'search')
      ],
    );
  }
}
