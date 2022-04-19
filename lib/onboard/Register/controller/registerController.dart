// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class RegisterController extends GetxController {
  var usernameController = TextEditingController();
  var passwordControllers = TextEditingController();
  var againPasswordControllers = TextEditingController();
  var emailController = TextEditingController();
  var currentIndex = 0.obs;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late FocusNode focusNode;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNode = FocusNode();
  }

  String? passworrdValidate(String? value) =>
      value!.length < 6 ? "Şifreniz 6 karakterden büyük olmalı " : null;
  String? kontrolEmail(String value) =>
      GetUtils.isEmail(value) ? "E-maili kontrol ediniz" : null;

 String? usernameValidate (String value)=> value.length<4?"Kullanıcı isminiz 4 haneden büyük olmalı" :null;
}
