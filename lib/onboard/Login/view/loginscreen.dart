import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/Button.dart';
import 'package:psikoz_me/core/components/TextField.dart';
import 'package:psikoz_me/core/components/StackBar.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/RouteConstants.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/onboard/Login/view/forgetPassword.dart';
import 'package:psikoz_me/onboard/Widgets/ForgetPassword.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    var authContoller = Get.find<AuthService>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const PsikozStack(),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PsikozTextField(
                text: LoginConstants.MAIL_TEXT,
                icon: const Icon(
                  Icons.email,
                  size: 20,
                ),
                style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                controller: controller.emailController),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 8.0, left: 8, top: 10, bottom: 2),
            child: PsikozTextField(
              obsureText: controller.isVisible.value,
              obsureIcon: Obx(
                () => GestureDetector(
                  onTap: () => controller.isVisible.toggle(),
                  child: Icon(
                    controller.isVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility_off,
                    color: Get.isDarkMode
                        ? controller.isVisible.value
                            ? ColorPallete.BLUECOLOR
                            : Colors.white
                        : controller.isVisible.value
                            ? ColorPallete.BLUECOLOR
                            : Colors.black54,
                    size: 20,
                  ),
                ),
              ),
              text: LoginConstants.PASSWORD_TEXT,
              icon: const Icon(
                Icons.lock,
                size: 20,
              ),
              style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
              controller: controller.passwordController,
            ),
          ),
          ForgetPassword(
            onPressed: () => Get.to(const ForgetPasswordPage()),
          ),
          PsikozButton(
              text: LoginConstants.LOGIN_TEXT,
              colors: ColorPallete.PURPLECOLOR,
              onTap: () => GetUtils.isEmail(controller.emailController.text) &&
                      controller.passwordController.text.length > 6
                  ? authContoller.signIn(controller.emailController.text,
                      controller.passwordController.text)
                  : Get.snackbar(
                    
                      "Hata", "Email yada Şifreniz hatalıdır. Tekrar Deneyiniz",
                      backgroundColor: Colors.red,
                      animationDuration: const Duration(seconds: 3),
                      )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Hala Bir Hesaba Sahip Değilmisiniz ?",
                  style: Get.theme.textTheme.headline1),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () => Get.toNamed(Routes_Constant.REGISTER),
                  child: Text("Kayıt Olun",
                      style: Get.theme.textTheme.headline1!
                          .copyWith(color: ColorPallete.BLUECOLOR)))
            ]),
          ),
        ],
      ),
    );
  }
}
