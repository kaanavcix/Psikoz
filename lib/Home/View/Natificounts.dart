// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
class NatiScreen extends StatelessWidget {
  const NatiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("Natification",style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
    ));
  }
}
