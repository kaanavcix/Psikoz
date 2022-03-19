// ignore_for_file: file_names

import 'package:get/get.dart';

import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';

class LoginControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
    );
  }
}
