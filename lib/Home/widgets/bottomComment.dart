// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

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
              backgroundImage:
                  NetworkImage(commentControll.profileModel.first.image),
            ),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow:const  [BoxShadow(color: Color.fromARGB(255, 209, 206, 206),spreadRadius: 1,blurRadius: 1)]
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
                          commentControll.profileModel.first.username,
                          controller.auth.currentUser!.uid,
                          commentControll.profileModel.first.image)!
                      .then(
                          (value) => commentControll.commentControl.text = "");
                },
                child: const Icon(
                  Icons.send,
                  size: 20,
                )),
          )
        ],
      ),
    );
  }
}
