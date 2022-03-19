import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/containers/Login_register_background.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/register_constant.dart';
import 'package:psikoz_me/core/constants/routes_constant.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:psikoz_me/core/init/service/authService.dart';

import 'package:psikoz_me/onboard/Register/controller/registerController.dart';
import 'package:psikoz_me/onboard/Widgets/EmailInput.dart';
import 'package:psikoz_me/onboard/Widgets/PasswordInput.dart';
import 'package:psikoz_me/onboard/Widgets/UserInput.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RegisterController>();
    var controller2 = Get.find<AuthService>();

    return Scaffold(
        body: LinearGradientBackground(
            widget: Center(
          child: Container(
            width: Get.width * 0.75,
            height: Get.height * 0.65,
            decoration: Register_Constants.BOXDECORATION,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
              height: 13,
                ),
                UserInput(userController: controller.usernameController),
                EmailInput(emailController: controller.emailController),
                PasswordInput(
              passwordController: controller.passwordControllers,
              name: Register_Constants.PASSWORD_TEXT,
                ),
                PasswordInput(
              passwordController: controller.againPasswordControllers,
              name: Register_Constants.PASSWORD_AGAIN_TEXT,
                ),
                const SizedBox(height: 10),
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                  key: UniqueKey(),
                  onTap: () {
                    if ((controller.againPasswordControllers.text ==
                            controller.passwordControllers.text) &&
                        (controller.usernameController.text.length > 4) &&
                        (controller.passwordControllers.text.length > 6) &&
                        (controller.emailController.text.length > 7)) {
                      controller2.createPerson(
                              controller.usernameController.text,
                              controller.emailController.text,
                              controller.passwordControllers.text,
                              controller.againPasswordControllers.text)
                          .then(
                              (value) => Get.offNamed(Routes_Constant.LOGIN))
                          .catchError(
                              // ignore: invalid_return_type_for_catch_error
                              (error) => Get.snackbar("Hi ", "Hatanız var"));
                    } else {
                      Get.snackbar("Hi", "Bilgilerinizi gözden geçiriniz",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.transparent);
                    }
                  },
                  child: Container(
                      child: Center(
                        child: Text(Register_Constants.REGISTER_BUTTON_TEXT,
                            style: Login_Constants.NUNITOTEXT_STYLE_W700),
                      ),
                      width: 90,
                      height: 35,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: Search_Constant.LINEARGRADIENT_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ))),
                )
              ],
            ),
          ),
        ),
            
          ));
  }
}
