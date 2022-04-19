// ignore_for_file: file_names, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';

class PostTextField extends StatelessWidget {
  PostTextField({
    required this.maxLength,
    required this.maxLines,
    required this.minLines,
    Key? key,
  }) : super(key: key);

  var maxLines;
  var maxLength;
  var minLines;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewPostController());
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 9),
      child: TextField(
        style: TextStyle(color: Colors.white),
          autofocus: true,
          controller: controller.postController,
          keyboardType: TextInputType.text,
          maxLines: maxLines,
          cursorWidth: 3,
          maxLength: maxLength,
          minLines: minLines,
          cursorRadius: const Radius.circular(20),
          cursorColor: ColorPallete.BLUECOLOR,
           decoration: const InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none) ),
    );
  }
}
