// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';

class NatiScreen extends StatelessWidget {
  const NatiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text("Natification",
          style: Get.textTheme.headline6!.copyWith(color: Colors.white)),
    ));
  }
}
