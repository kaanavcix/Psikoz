import 'package:flutter/material.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/core/components/BottomNavigationBar.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/components/bottomnaav.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/init/routes/pages.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigatiorController());
    return GetBuilder<BottomNavigatiorController>(
        builder: ((_) => Scaffold(
            body: tumPages[_.selectedItemPosition.value],
            bottomNavigationBar: PsikozBottomNavigationBar(
              currentIndex: _.selectedItemPosition.value,
              controller: _,
            ))));
  }
}
