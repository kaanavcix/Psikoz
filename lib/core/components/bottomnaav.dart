import 'package:flutter/material.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:get/get.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class PsikozBottomNavigationBar extends StatelessWidget {
  PsikozBottomNavigationBar(
      {Key? key, required this.currentIndex, required this.controller})
      : super(key: key);

  int currentIndex;
  BottomNavigatiorController controller;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Get.isDarkMode ? Colors.black : Colors.white,
      elevation: 0,
      child: SizedBox(
        height: 55,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: MfgLabs.home,
                  selected: currentIndex == 0,
                  onPressed: () {
                    int index = 0;
                    controller.selectedItem(index);
                  }),
              IconBottomBar(
                  text: "Search",
                  icon: Iconic.chat_inv,
                  selected: currentIndex == 1,
                  onPressed: () {
                    int index = 1;
                    controller.selectedItem(index);
                  }),
              IconBottomBar2(
                  text: "Add",
                  icon: Icons.add,
                  selected: currentIndex == 2,
                  color: Colors.white,
                  onPressed: () {
                    int index = 2;
                    controller.selectedItem(index);
                  }),
              IconBottomBar(
                  text: "Search",
                  icon: MfgLabs.search,
                  selected: currentIndex == 3,
                  onPressed: () {
                    int index = 3;
                    controller.selectedItem(index);
                  }),
              IconBottomBar(
                  text: "Person",
                  icon: Typicons.user,
                  selected: currentIndex == 4,
                  onPressed: () {
                    int index = 4;
                    controller.selectedItem(index);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed, })
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            icon,
            size: 24,
            color: Get.isDarkMode
                ? selected
                    ? ColorPallete.BLUECOLOR
                    : Colors.white70
                : selected
                    ? ColorPallete.BLUECOLOR
                    : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed,
      required this.color})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorPallete.BLUECOLOR,
              ColorPallete.PURPLECOLOR,
            ]),
            shape: BoxShape.circle),
        child: Icon(
          icon,
          size: 25,
          color: color,
        ),
      ),
    );
  }
}
