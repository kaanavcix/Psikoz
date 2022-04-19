// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/components/containers/Login_register_background.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:psikoz_me/core/constants/RouteConstants.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';
import 'package:psikoz_me/onboard/Login/view/forgetPassword.dart';
import 'package:psikoz_me/onboard/Widgets/EmailInput.dart';
import 'package:psikoz_me/onboard/Widgets/ForgetPassword.dart';
import 'package:psikoz_me/onboard/Widgets/PasswordInput.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final controller2 = Get.find<AuthService>();

    return Scaffold(
      body: LinearGradientBackground(
          widget: Center(
              child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        child: loginField(controller.emailController,
            controller.passwordController, controller2, context, controller),
      ))),
    );
  }

  Widget loginField(
      TextEditingController emailController,
      TextEditingController passwordController,
      AuthService controller,
      BuildContext context,
      LoginController loginController) {
    return Column(
      children: [
        SvgPicture.asset(
          LoginConstants.LOGO_IMAGE2_SVG,
          semanticsLabel: "Logo Svg",
          color: Colors.white,
          height: 110,
        ),
        const SizedBox(
          height: 20,
        ),
        LoginInput(
          emailController,
          passwordController,
          controller,
          loginController,
          context,
        ),
      ],
    );
  }

  Widget LoginInput(
      TextEditingController emailController,
      TextEditingController passwordController,
      AuthService controller,
      LoginController logincontroller,
      BuildContext context) {
    GlobalKey<FormState> validateKey = GlobalKey<FormState>();
    return Container(
        child: Form(
          key: validateKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Text(LoginConstants.LOGIN_TEXT,
                    style: LoginConstants.NUNITOTEXT_STYLE),
              ),
              EmailInput(
                validator: (p0) {
                  return p0 != null && p0.contains("@")
                      ? "Lütfen Eposta gieiniz"
                      : null;
                },
                onFieldSubmitted: (p0) =>
                    logincontroller.focusnode.requestFocus(),
                emailController: emailController,
              ),
              PasswordInput(
                passwordController: passwordController,
                name: LoginConstants.PASSWORD_TEXT,
              ),
              ForgetPassword(
                onPressed: () => Get.to(ForgetPasswordPage()),
              ),
              LoginButton(controller, emailController, passwordController),
              SizedBox(height: 5),
              SignInWith(),
            ],
          ),
        ),
        width: Get.width * 0.75,
        height: Get.height * 0.52,
        decoration: LoginConstants.BOXDECORATION);
  }

  Center TextButton() {
    return Center(
        child: Text(
      LoginConstants.OR_LOGIN_WITH_TEXT,
      style: LoginConstants.NUNITOTEXT_JUST_TEXTSIZE,
    ));
  }

  Widget LoginButton(
      AuthService controller,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
          key: UniqueKey(),
          onTap: () {
            if (emailController.text.isNotEmpty &&
                passwordController.text.length > 6) {
              controller
                  .signIn(emailController.text, passwordController.text)
                  // ignore: invalid_return_type_for_catch_error
                  .catchError((e) => Get.snackbar("ERROR", e.toString(),
                      backgroundColor: Colors.red));
            } else {
              Get.snackbar("Hi", "Hatalı Bilgi Girdiniz",
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: Container(
              child: Center(
                child: Text(LoginConstants.LOGIN_TEXT,
                    style: LoginConstants.NUNITOTEXT_STYLE_W700),
              ),
              width: 90,
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: ColorPallete.LINEARGRADIENT_COLOR,
                ),
                borderRadius: BorderRadius.circular(10),
              ))),
    );
  }

  Widget SignInWith() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Hala Bir Hesaba Sahip Değilmisiniz ?",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 12),
        ),
        InkWell(
          onTap: () => Get.toNamed(Routes_Constant.REGISTER),
          child: Text(
            "Kayıt Olun",
            style: LoginConstants.NUNITOTEXT_STYLE_W700
                .copyWith(color: ColorPallete.BLUECOLOR),
          ),
        )
      ]),
    );
  }
}
