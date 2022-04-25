// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';

import 'package:get/get.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/CommonTextConstant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';
import 'package:psikoz_me/newPost/widgets/bottomSheet.dart';
import 'package:psikoz_me/newPost/widgets/bottomsheetdelete.dart';
import 'package:psikoz_me/newPost/widgets/postTextField.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller2 = Get.find<StatusService>();
    var controller = Get.put(NewPostController());
    var controller3 = Get.find<HomeController>();
    var controller10 = Get.find<BottomNavigatiorController>();
    var controller5 = Get.put(Variable());
    var random = Random().nextInt(1000);
    String generate = random.toString();
    var anonmyName = "${CommonTextConstants.ANONIM}$generate";
    return Scaffold(
      //backgroundColor: Colors.white38,
      resizeToAvoidBottomInset: true,
      body:  SafeArea(
        child: Column(
                children: [
                  PostIngerident(
                      controller4: controller3, controller: controller),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => controller.selectedImage.value == " "
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 100,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 212, 212, 212),
                                borderRadius: BorderRadius.circular(23),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 209, 207, 207),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: controller.selectedImage.value == " "
                                ? const Center(
                                    child: SizedBox(height: 0, width: 0))
                                : GestureDetector(
                                    onLongPress: () => const BottomsheetonLong(),
                                    child: Image.file(
                                      File(controller.selectedImage.value!.path),
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                          ),
                        )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15,bottom: 5),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.bottomSheet(const bottomSheet());
                                },
                                icon: Icon(Elusive.attach_circled,
                                    size: 35,
                                    color: ColorPallete.PURPLECOLOR)),
                            GetBuilder<NewPostController>(
                                builder: ((controller) => DropdownButton(dropdownColor: ThemeConstant.logoMode,
                                      borderRadius: BorderRadius.circular(20),
                                      underline: const SizedBox(),
                                      hint: Text(
                                        controller.selectedValue.value == ""
                                            ? "Konu seçiniz"
                                            : controller.selectedValue.value,
                                        style:
                                             Get.textTheme.headline1
                                      ),
                                      onChanged: (String? value) =>
                                          controller.setSelected(value!),
                                      items: Variable.PHYSCOLOGYOBJECTNAME
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem(
                                          child: Text(value,style:  Get.textTheme.headline1),
                                          value: value,
                                        );
                                      }).toList(),
                                    ))),
                            GestureDetector(
                              onTap: () {
                                if (controller.postController.value.text.length >
                                        10 &&
                                    controller.selectedImage.value != " ") {
                                  controller2
                                      .addPost(
                                          controller.postController.text,
                                          controller.selectedImage.value,
                                          controller.switchValue.value == true
                                              ? controller3.profileModel.first.anonim
                                              : controller3
                                                  .profileModel.first.username,
                                          controller.dateFormat.value,
                                          controller.switchValue.value == true
                                              ? ""
                                              : controller3
                                                  .profileModel.first.image,
                                          controller.selectedValue.value,
                                          0,
                                          controller.switchValue.value == true
                                              ? ""
                                              : controller3
                                                  .profileModel.first.degree)
                                      .then((value) {
                                    controller10.selectedItemPosition.value = 0;
                                    controller.postController.text = "";
                                    controller.selectedImage.value = " ";
                                    controller.selectedValue.value = "";
      
                                    controller.isLoading.toggle();
                                  }).catchError((error) {
                                    Get.snackbar("Please",
                                        "Upss Sorry there is a wrong stuff please say again");
                                  }).whenComplete(
                                          () => controller.isLoading.toggle());
                                } else if (controller
                                        .postController.value.text.length >
                                    10) {
                                  controller2
                                      .addText(
                                          controller.postController.text,
                                          controller.switchValue.value == true
                                              ? controller3.profileModel.first.anonim
                                              : controller3
                                                  .profileModel.first.username,
                                          controller.dateFormat.value,
                                          controller.switchValue.value == true
                                              ? ""
                                              : controller3
                                                  .profileModel.first.image,
                                          controller.selectedValue.value,
                                          0,
                                          controller.switchValue.value == true
                                              ? ""
                                              : controller3
                                                  .profileModel.first.degree)
                                      .then((value) {
                                    controller10.selectedItemPosition.value = 0;
                                    controller.postController.text = "";
                                    controller.selectedValue.value = "";
                                    controller.isLoading.toggle();
                                  }).catchError((error) {
                                    Get.snackbar("Please",
                                        "Upss Sorry there is a wrong stuff please say again");
                                  }).whenComplete(
                                          () => controller.isLoading.toggle());
                                } else {
                                  Get.snackbar("Please",
                                      "Lütfen karakter sayısı 10 den fazla olsun");
                                }
                              },
                              child: Container(
                                
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: const [BoxShadow()],
                                      gradient: LinearGradient(
                                          colors: ColorPallete
                                              .LINEARGRADIENT_COLOR),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(23),
                                          topRight: Radius.circular(23),
                                          bottomLeft: Radius.circular(23))),
                                  child: Center(
                                      child: Text(
                                    CommonTextConstants.GONDER,
                                    style: ProfileConstants.BUTTONSTYLE,
                                  ))),
                            ),
                          ]),
                      height: 50,
                      decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                              bottomLeft: Radius.circular(23)),
                        color: Get.isDarkMode? AppColor.buttonBackgroundColorDark : AppColor.buttonBackgroundColor,
                       ),
                    ),
                  ),
                ],
              ),
      )
          
    );
  }
}
