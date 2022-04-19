// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/CommonTextConstant.dart';
import 'package:psikoz_me/core/constants/colorpallette.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/widgets/textField.dart';
class PostIngerident extends StatelessWidget {
  const PostIngerident({
    Key? key,
    required this.controller4,
    required this.controller,
  }) : super(key: key);

  final HomeController controller4;
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
                            backgroundColor: ColorPallete.BLUECOLOR,
                            backgroundImage: controller4.profileModel.first.image !=
                                    " "
                                ? NetworkImage(controller4.profileModel.first.image)
                                : const NetworkImage("https://picsum.photos/200"),// şura-ya bir ayar çekelim
                          ),
                        ),
                        const SizedBox( // bakalım
                          width: 40,
                        ),
                        Expanded(
                          flex: 5,
                          child: Obx(() => SwitchListTile(
                            inactiveThumbColor: ColorPallete.PURPLECOLOR,
                                activeColor: ColorPallete.BLUECOLOR,
                                value: controller.switchValue.value,
                                onChanged: (value) {
                                  controller.switchValue.value = value;
                                },
                                title: Text(
                                  CommonTextConstants.ADDANONIMTEXT,
                                  style: LoginConstants.NUNITOTEXT_STYLE_W700
                                      .copyWith(
                                          fontSize: 10, color: Get.isDarkMode?Colors.white:Colors.black),
                                ),
                              )),
                        ),
                      ],
                    ),
                   PostTextField(maxLength: 500,maxLines: 3,minLines: 2,),
                  ]),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5,color: Colors.black26),
                color: Get.isDarkMode?Colors.black54:Colors.
                white54,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        );
  }
}
