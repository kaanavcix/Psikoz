// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

class HomeController extends GetxController {
  var selectedTag = "".obs;
  var controller = Get.put(StatusService());
  var data = 0;
  TextEditingController commentControl = TextEditingController();
  var isSave = false.obs;

  
  
}
