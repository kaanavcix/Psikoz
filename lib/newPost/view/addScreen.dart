// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';
import 'package:psikoz_me/core/constants/addPost_constant.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/commonUsing_constant.dart';
import 'package:get/get.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';
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
    var controller10 = Get.find<BottomNavigatiorController>();
    var controller4 = Get.find<AuthService>();
    var controller5 = Get.put(Variable());
    var random = Random().nextInt(1000);
    String generate = random.toString();
    var anonmyName = "${CommonVariable.ANONIM}$generate";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: controller.isLoading.value? Column(
        children: [
          const SizedBox(height: 30),
          PostIngerident(controller4: controller4, controller: controller),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 100,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 209, 207, 207),
                          blurRadius: 1,
                          spreadRadius: 1,
                        )
                      ]),
                  child: controller.selectedImage.value == " "
                      ? const Center(child: SizedBox(height: 0, width: 0))
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
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(const bottomSheet());
                        },
                        icon: Icon(Elusive.attach_circled,
                            size: 35, color: BottomBar_Constant.COLORGREENKA)),
                    GetBuilder<NewPostController>(
                        builder: ((controller) => DropdownButton(
                              borderRadius: BorderRadius.circular(20),
                              underline: const SizedBox(),
                              hint: Text(
                                controller.selectedValue.value == ""
                                    ? "Konu seçiniz"
                                    : controller.selectedValue.value,
                                style: const TextStyle(color: Colors.black),
                              ),
                              onChanged: (String? value) =>
                                  controller.setSelected(value!),
                              items: controller5.PHYSCOLOGYOBJECTNAME
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ))),
                    GestureDetector(
                      onTap: () {
                        if (controller.postController.value.text.length > 50 &&
                            controller.selectedImage.value != " ") {
                          controller2
                              .addPost(
                            controller.postController.text,
                            controller.selectedImage.value,
                            controller.switchValue.value == true
                                ? anonmyName
                                : controller4.myUsername.value,
                            controller.dateFormat.value,
                            controller.switchValue.value == true
                                ? ""
                                : controller4.myUserAvatar.value,
                            controller.selectedValue.value,
                            0,
                          )
                              .then((value) {
                            controller10.selectedItemPosition.value = 0;
                            controller.postController.text = "";
                            controller.selectedImage.value = " ";
                            controller.selectedValue.value = "";

                            controller.isLoading.value !=
                                controller.isLoading.value;
                          }).catchError((error) {
                            Get.snackbar("Please",
                                "Upss Sorry there is a wrong stuff please say again");
                          }).whenComplete(() => controller.isLoading.value!= controller.isLoading.value);
                        } else if (controller.postController.value.text.length >
                            50) {
                          controller2
                              .addText(
                                  controller.postController.text,
                                  controller.switchValue.value == true
                                      ? anonmyName
                                      : controller4.myUsername.value,
                                  controller.dateFormat.value,
                                  controller.switchValue.value == true
                                      ? ""
                                      : controller4.myUserAvatar.value,
                                  controller.selectedValue.value,
                                  0)
                              .then((value) {
                            controller10.selectedItemPosition.value = 0;
                            controller.postController.text = "";
                            controller.selectedValue.value = "";
                            controller.isLoading.value !=
                                controller.isLoading.value;
                          }).catchError((error) {
                            Get.snackbar("Please",
                                "Upss Sorry there is a wrong stuff please say again");
                          }).whenComplete(() =>
                                  controller.isLoading.value !=
                                  controller.isLoading.value);
                        } else {
                          Get.snackbar("Please",
                              "Lütfen karakter sayısı 50 den fazla olsun");
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: const [BoxShadow()],
                              gradient: LinearGradient(
                                  colors: Search_Constant.LINEARGRADIENT_COLOR),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(23),
                                  topRight: Radius.circular(23),
                                  bottomLeft: Radius.circular(23))),
                          child: Center(
                              child: Text(
                            AddPostConstant.GONDER,
                            style: ProfileConstants.BUTTONSTYLE,
                          ))),
                    ),
                  ]),
              height: 50,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 226, 226, 226),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
            ),
          ),
        ],
      ): Center(child: CircularProgressIndicator(),),
    );
  }
}
