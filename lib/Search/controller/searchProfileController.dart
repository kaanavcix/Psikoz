// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:psikoz_me/newPost/view/models/addmodel.dart';

class SearchProfileController extends GetxController {
  var controller2 = Get.find<SearchController>();
  RxList<Post2> searchPost = RxList<Post2>();

  @override
  void onInit() {
    super.onInit();
    searchPost.bindStream(controller2.getSearchPost());
  }
}
