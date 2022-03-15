// ignore_for_file: file_names, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';

class textField extends StatelessWidget {
  textField({
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
        autofocus: true,
        controller: controller.postController,
        keyboardType: TextInputType.text,
        maxLines: maxLines,
        cursorWidth: 3,
        maxLength: maxLength,
        minLines: minLines,
        cursorRadius: const Radius.circular(20),
        cursorColor: Search_Constant.COLORBLUEKA,
        decoration: const InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.black),
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
            ))),
      ),
    );
  }
}
