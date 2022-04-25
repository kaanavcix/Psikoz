// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Profile/view/model/profile_model.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/newPost/view/models/addmodel.dart';

class HomeController extends GetxController {
  var selectedTag = "".obs;
  var controller = Get.find<StatusService>();
  var data = 0;
  TextEditingController commentControl = TextEditingController();
  var isSave = false.obs;
  var tabIndex = 0.obs; 
  RxList<ProfileModel2> profileModel = RxList<ProfileModel2>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileModel.bindStream(controller.getCurrentData());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUidForPost();
  }

  getUidForPost() {
    var ref = controller.collectionreference
        //.where("uid", whereIn: profileModel.first.following)
        .snapshots()
        .map((event) => event.docs.map((e) => Post2.fromMap(e)).toList());

    debugPrint(ref.toString());
  }

  Stream<List<Post3>> getCustomPost() {
    var customData = controller.collectionreference
        .where("username",
            isEqualTo: profileModel.first.username) //bakalım buna
        .snapshots()
        .map((event) => event.docs.map((e) => Post3.fromMap(e)).toList());

    return customData;
  }
}
