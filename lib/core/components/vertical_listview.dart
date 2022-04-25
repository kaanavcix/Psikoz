import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:get/get.dart';

class VerticalListview extends StatelessWidget {
  VerticalListview({required this.controller, Key? key}) : super(key: key);
  HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ListView.builder(
        //padding: EdgeInsets.symmetric(vertical: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.tabIndex.value = index;
              debugPrint(controller.tabIndex.value.toString());
            },
            child: Container(
              //  margin: EdgeInsets.symmetric(horizontal: 3),
              //color: Colors.blue,
              width: 100,
              //  height: 20,
              decoration: (BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: controller.tabIndex.value == index
                      ? ColorPallete.BLUECOLOR
                      : Colors.white30)),
              child: Center(
                  child: Text(
                Variable.PHYSCOLOGYOBJECTNAME[index],
                textAlign: TextAlign.center,
              )),
            ),
          );
        },
        itemCount: Variable.PHYSCOLOGYOBJECTNAME.length,
      ),
    );
  }
}
