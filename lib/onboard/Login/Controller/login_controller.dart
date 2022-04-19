import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isVisible = true.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController forgetPassword = TextEditingController();


  late FocusNode focusnode;

  @override
  void onInit() {
    super.onInit();
    focusnode = FocusNode();
  }
}
