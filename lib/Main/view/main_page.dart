import 'package:flutter/material.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/core/components/bottom_navigation/bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/init/routes/pages.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigatiorController controller =
        Get.put(BottomNavigatiorController());
    return Scaffold(
      body: Obx(() => tumPages[controller.selectedItemPosition.value],),
          bottomNavigationBar: Obx(() => SnakeBottomNavigationBar(
                selectedIndex: controller.selectedItemPosition.value,
                onTap: (p0) => controller.selectedItemPosition.value = p0,
              )))
    ;
  }
}
