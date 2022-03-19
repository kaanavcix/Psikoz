// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/Main/controller/bottomnavi_controller.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';

import 'package:psikoz_me/newPost/controller/newpost_controller.dart';

class NewPostBinding implements Bindings {
  @override
  void dependencies() {
  
    Get.put<NewPostController>(NewPostController());
    Get.put(BottomNavigatiorController());
    Get.lazyPut(() => Variable());
  }
}
