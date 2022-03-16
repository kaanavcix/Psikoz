// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

class ProfileController extends GetxController {
  var secondPath = " ".obs;
  var pickerImage = ImagePicker();
  var controller = Get.put(AuthService());
  Rx<dynamic> selectedImage = Rx<dynamic>(null);
  var controller2 = Get.put(StatusService());

  @override
  void onInit() async {
    super.onInit();
    controller.getUserCurrentData();
  }

  @override
  void onReady() {
    super.onReady();
    controller2.post5.bindStream(controller2.getCustomPost());
    controller2.post6.bindStream(controller2.getSavePost());
  }

  Future<void> getImage(ImageSource imagesource) async {
    var pickedFile = await pickerImage.pickImage(source: imagesource);
    if (pickedFile != null) {
      selectedImage.value = pickedFile;

      controller.getProfileImage(selectedImage.value);

      secondPath.value = pickedFile.path;
      debugPrint(secondPath.toString());
    } else {
      Get.snackbar("Hi", "No photo");
    }
  }
}
