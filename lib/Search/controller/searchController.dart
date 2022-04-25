// ignore_for_file: file_names, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/newPost/view/models/addmodel.dart';

class SearchController extends GetxController {
  late List<PhyscologyObject> physcologyObject;
  var controller = Get.put(Variable());
  var controller2 = Get.find<AuthService>();
    var controller3 = Get.find<StatusService>();

  var isShowed = false.obs;
  var username = "".obs;
  var image = "".obs;
  var follow = [].obs;
  var isFollowing = false.obs;
  var followNumber = 0.obs;
  var degreeNumber = "".obs;

  TextEditingController searchControl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    physcologyObject = [];
    ListOlusturucu();
    ListEkleme();
  }

  List<PhyscologyObject> ListOlusturucu() {
    List<PhyscologyObject> geciciObject = [];
    for (var i = 0; i < 9; i++) {
      var Name = Variable.PHYSCOLOGYOBJECTNAME[i];
      var Asset = controller.AssetImage[i];
      PhyscologyObject object = PhyscologyObject(name: Name, imageAsset: Asset);
      geciciObject.add(object);
    }
    return geciciObject;
  }

  void ListEkleme() {
    physcologyObject = ListOlusturucu();
  }

  getSearchUser(String uid) async {
    var ref = await FirebaseFirestore.instance
        .collection("Person")
        .doc(uid)
        .get()
        .then((value) {
      username.value = value.data()!["username"];
      image.value = value.data()!["Image"];
      follow.value = value.data()!["Follow"];
      followNumber.value = value.data()!["Follow"].length;
      isFollowing.value = follow.contains(controller2.auth.currentUser!.uid);
      degreeNumber.value = value.data()!["degreeNumber"];

    });

    return ref;
  }

  Stream<List<Post2>> getSearchPost() {
    var ref = FirebaseFirestore.instance
        .collection("Status")
        .where("username", isEqualTo: username.value)
        .snapshots()
        .map((event) => event.docs.map((e) => Post2.fromMap(e,)).toList());
    return ref;
  }
}
