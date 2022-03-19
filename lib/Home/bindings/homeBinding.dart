// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
