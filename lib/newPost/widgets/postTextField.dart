// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/addPost_constant.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/widgets/textField.dart';
class PostIngerident extends StatelessWidget {
  const PostIngerident({
    Key? key,
    required this.controller4,
    required this.controller,
  }) : super(key: key);

  final AuthService controller4;
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal:5.0),
          child: Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: BottomBar_Constant.COLORBLUEKA,
                            backgroundImage: controller4.myUserAvatar.value !=
                                    " "
                                ? NetworkImage(controller4.myUserAvatar.value)
                                : const NetworkImage("https://picsum.photos/200"),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          flex: 5,
                          child: Obx(() => SwitchListTile(
                                activeColor: BottomBar_Constant.COLORBLUEKA,
                                value: controller.switchValue.value,
                                onChanged: (value) {
                                  controller.switchValue.value = value;
                                },
                                title: Text(
                                  AddPostConstant.ANONIMTEXT,
                                  style: Login_Constants.NUNITOTEXT_STYLE_W700
                                      .copyWith(
                                          fontSize: 10, color: Colors.black),
                                ),
                              )),
                        ),
                      ],
                    ),
                   textField(maxLength: 500,maxLines: 3,minLines: 2,),
                  ]),
            ),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 212, 210, 210),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        );
  }
}
