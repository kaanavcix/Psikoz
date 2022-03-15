// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';
class bottomSheet extends StatelessWidget {
  const bottomSheet({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewPostController());
    return Container(
      height: 180,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(children: [
          ListTile(
            onTap: (() => controller
                .getImage(ImageSource.camera)
                .then((value) => Get.back())),
            leading: const Icon(Icons.camera),
            title: const Text("Kamera"),
          ),
          ListTile(
            onTap: (() => controller
                .getImage(ImageSource.gallery)
                .then((value) => Get.back())),
            leading: const Icon(Icons.photo_album),
            title: const Text("Album"),
          ),
          controller.selectedImage.value!=" " ?    ListTile(
            onTap: (() {
              controller.selectedImage.value = " ";
              Get.back();
            }),
            leading: const Icon(Icons.delete),
            title: const Text("Sil"),): const Text("")
        ]),
      ),
    );
  }
}
