// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/Message/view/model/ChatModel.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageSreenController extends GetxController {
  RxList<ChatModel> chat = RxList<ChatModel>([]);

  var controller = Get.put(ChatController());
  var username = "".obs;
  var profileImage = "".obs;
  TextEditingController messageOpenController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    chat.bindStream(controller.getConversation());
  }

  getSearchUser(String uid) async {
    var ref = await FirebaseFirestore.instance
        .collection("Person")
        .doc(uid)
        .get()
        .then((value) {
      username.value = value.data()!["username"];
      profileImage.value = value.data()!["Image"];
    });

    return ref;
  }
}
