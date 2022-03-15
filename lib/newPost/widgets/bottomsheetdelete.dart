import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/newPost/controller/newpost_controller.dart';

class BottomsheetonLong extends StatelessWidget {
  const BottomsheetonLong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewPostController());
    return Container(
      height: 300,
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
          ListTile(
            onTap: (() {
              controller.selectedImage.value = " ";
              Get.back();
            }),
            leading: const Icon(Icons.delete),
            title: const Text("Sil"),
          ),
        ]),
      ),
    );
  }
}
