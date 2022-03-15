// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';

class PasswordInput extends StatelessWidget {
   PasswordInput(
      {Key? key, required this.passwordController, required this.name})
      : super(key: key);
  TextEditingController passwordController;
  String name;
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Obx(
          () => TextFormField(
            obscureText: controller.isVisible.value,
            controller: passwordController,
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    // controller.IsVisible.value = !controller.IsVisible.value;
                    controller.isVisible.toggle();
                  },
                  child: Icon(
                    controller.isVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                label: Text(name,
                    style: Login_Constants.NUNITOTEXT_JUST_TEXTSIZE
                        .copyWith(color: Colors.black))),
          ),
        ));
  }
}
