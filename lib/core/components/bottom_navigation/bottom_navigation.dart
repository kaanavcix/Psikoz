// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class SnakeBottomNavigationBar extends StatelessWidget {
  SnakeBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  int selectedIndex;
  void Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.gradient(
      shadowColor: Colors.white,
      backgroundGradient:
          const LinearGradient(colors: [Colors.white, Colors.white]),
      snakeViewGradient:
          LinearGradient(colors: BottomBar_Constant.LINEARGRADIENT_COLOR),
      selectedItemGradient:
          const LinearGradient(colors: [Colors.black, Colors.black]),
      unselectedItemGradient:
          const LinearGradient(colors: [Colors.grey, Colors.grey]),
      shape: BottomBar_Constant.BOTTOMSHAPEBORDER,
      elevation: 5,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: selectedIndex,
      onTap: onTap,
      //padding: EdgeInsets.all(8),
      snakeShape: SnakeShape.indicator,
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
