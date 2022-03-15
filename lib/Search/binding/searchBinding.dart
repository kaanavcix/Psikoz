// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:psikoz_me/Search/controller/searchController.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}
