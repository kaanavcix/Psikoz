// ignore_for_file: file_names

import 'package:get/get.dart';

import 'package:psikoz_me/onboard/Register/controller/registerController.dart';

class RegisterControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
    
  }
}
