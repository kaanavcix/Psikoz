import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewPostController extends GetxController {
  var switchValue = true.obs;
  var selectedValue = "".obs;

  var isLoading = true.obs;

  var random = Random().nextInt(100).obs;

  var pickerImage = ImagePicker();
  Rx<dynamic> selectedImage = Rx<dynamic>(" ");
  var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).obs;

  TextEditingController postController = TextEditingController();
  //var pickImage = Rxn<String>(" ");
  //eğer Rxn olursa boş değer dönebiliyorsunuz

  Future<void> getImage(ImageSource imagesource) async {
    var pickedFile = await pickerImage.pickImage(source: imagesource);
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    } else {
      Get.snackbar("Hi", "No photo",backgroundColor: Colors.red);
    }
  }

  void setSelected(String value) {
    selectedValue.value = value;
    update();
  }
}
