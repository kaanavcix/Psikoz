// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/stroage_service.dart';
import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';

class LoginControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(),
        permanent:
            true); //şu orospuçocuğu beni uğraşturdı ya ,// bu bağlılıkların silinmesini engelliyor
    Get.put(AuthService(), permanent: true);
    Get.put(StroageService(),permanent: true);
  }
}
