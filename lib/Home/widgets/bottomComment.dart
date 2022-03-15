// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

class BottomComment extends StatelessWidget {
  const BottomComment({required this.snap, Key? key}) : super(key: key);

  final dynamic snap;
  @override
  Widget build(BuildContext context) {
    var commentControll = Get.find<HomeController>();
    var controller = Get.find<AuthService>();
    var controller2 = Get.find<StatusService>();
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(controller.myUserAvatar.value),
            ),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                        controller: commentControll.commentControl,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            hintText: "...",
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            )))),
                  ))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
                onTap: () async {
                  await controller2
                      .postComment(
                          snap,
                          commentControll.commentControl.text,
                          controller.myUsername.value,
                          controller.auth.currentUser!.uid,
                          controller.myUserAvatar.value)!
                      .then(
                          (value) => commentControll.commentControl.text = "");
                },
                child: const Icon(
                  Icons.send,
                  size: 28,
                )),
          )
        ],
      ),
    );
  }
}
