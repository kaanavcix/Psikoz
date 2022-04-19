import 'dart:io';
import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/TextField.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/onboard/Register/controller/registerController.dart';
import 'package:psikoz_me/onboard/Register/view/stepper.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller2 = Get.find<AuthService>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorPallete.BLUECOLOR,
          title: const Text("Üye Ol"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Obx(() => steppertry(context, controller2)));
  }

  Stepper steppertry(BuildContext context, AuthService controller2) {
    return Stepper(
        margin: EdgeInsets.all(20),
        currentStep: controller.currentIndex.value,
        elevation: 0,
        onStepContinue: () =>
            controller.currentIndex.value == steps().length - 1
                ? controller2.createPerson(
                    controller.usernameController.text,
                    controller.emailController.text,
                    controller.passwordControllers.text,
                    controller.againPasswordControllers.text)
                : controller.currentIndex.value++,
        onStepCancel: () => controller.currentIndex.value == 0
            ? null
            : controller.currentIndex.value--,
        onStepTapped: (index) {
          controller.currentIndex.value = index;
        },
        type: StepperType.horizontal,
        steps: steps(),
        controlsBuilder: (context, ControlsDetails details) => Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(controller.currentIndex.value == 2
                      ? "Kayıt Ol"
                      : "Devam et"),
                  style: ElevatedButton.styleFrom(
                      primary: ColorPallete.BLUECOLOR,
                      fixedSize: Size.fromHeight(45) // size ayarlama
                      ),
                )),
                controller.currentIndex.value == 0
                    ? const SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : const SizedBox(
                        width: 16,
                      ),
                controller.currentIndex.value == 0
                    ? const SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : Expanded(
                        child: TextButton(
                        onPressed: details.onStepCancel,
                        child: Text("Geri Dön"),
                        style: TextButton.styleFrom(
                          primary: ColorPallete.PURPLECOLOR,
                            fixedSize: const Size.fromHeight(45)),
                      ))
              ],
            ));
  }
}

List<Step> steps() => [
      Step(
        isActive: controller.currentIndex.value >= 0,
        state: controller.currentIndex.value > 0
            ? StepState.complete
            : StepState.indexed,
        title: Text(
          "Kullanıcı adı",
          style: Get.textTheme.headline1,
        ),
        content: Column(
          children: [
            Text(
              "İlk olarak bir kullanıcı adı belirleyiniz",
              style: Get.textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8, top: 3, bottom: 20),
              child: PsikozTextField(
                  key: controller.formstate,
                  text: "Kullanıcı Adı",
                  icon: Icon(Icons.person, size: 20),
                  style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                  controller: controller.usernameController),
            ),
          ],
        ),
      ),
      Step(
        isActive: controller.currentIndex.value >= 1,
        title: Text("E-mail",
                      style: Get.textTheme.headline1,
),
        content: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 8.0, left: 8, top: 2, bottom: 20),
            child: PsikozTextField(
                text: "E-mail",
                icon: Icon(Icons.mail, size: 20),
                style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                controller: controller.emailController),
          ),
        ]),
      ),
      Step(
        isActive: controller.currentIndex.value >= 2,
        title: Text("Şifre",
               style: Get.textTheme.headline1,
),
        content: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 8.0, left: 8, top: 2, bottom: 2),
            child: PsikozTextField(
                text: "Şifre",
                icon: Icon(Icons.lock, size: 20),
                style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                controller: controller.passwordControllers),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8, top: 4, bottom: 20),
              child: PsikozTextField(
                  text: "Şifre (Yeniden)",
                  icon: const Icon(Icons.lock, size: 20),
                  style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                  controller: controller.againPasswordControllers)),
        ]),
      )
    ];
