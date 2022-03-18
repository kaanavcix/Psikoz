import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Message/view/model/chatModel.dart';
import 'package:psikoz_me/Profile/view/model/profile_model.dart';
import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/newPost/view/models/addmodel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/stroage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:psikoz_me/newPost/view/models/commentModel.dart';

class StatusService extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _storageService = Get.put(StroageService(), permanent: true);
  final autService = Get.put(AuthService(), permanent: true);
  final searchController = Get.put(SearchController());

  late CollectionReference collectionreference;
  late CollectionReference collectionreferenceComment;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var myFallow = [].obs;
  var myUsername = " ".obs;
  var myUserAvatar = "".obs;

  RxList<Post2> post4 = RxList<Post2>([]);
  RxList<Post3> post5 = RxList<Post3>([]);
  RxList<Post2> post6 = RxList<Post2>([]);
  RxList<Post2> post7 = RxList<Post2>([]);

  RxList<Comment> comment = RxList<Comment>([]);
  List<MessageModel> message = ([]);

  @override
  void onInit() {
    super.onInit();

    collectionreference = firestore.collection("Status");
    collectionreferenceComment = firestore
        .collection("Status")
        .doc(collectionreference.id)
        .collection("comment");
    post4.bindStream(getAllPost());
  }



//veri ekleme resimle
  Future<Post2> addPost(
    String title,
    XFile pickedImage,
    String username,
    String time,
    String profileurl,
    String tag,
    int likeCounter,
  ) async {
    var _mediaUrl = await _storageService.uploadMedia(File(pickedImage.path));
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (_mediaUrl == null) {
      _mediaUrl = "";
    }
    var documentRef = await collectionreference.add({
      "PostText": title,
      "image": _mediaUrl,
      "username": username,
      "time": time,
      "profileurl": profileurl,
      "tag": tag,
      "likeCounter": likeCounter,
      "likes": [],
      "Save": [],
      "uid": autService.auth.currentUser!.uid
    });

    return Post2(
        DocId: documentRef.id,
        PostText: title,
        image: _mediaUrl,
        username: username,
        time: time,
        profileurl: profileurl,
        tag: tag,
        likeCounter: likeCounter,
        likes: [],
        saves: []);
  }

  // sadece text
  Future<Post2> addText(
    String title,
    String username,
    String time,
    String profileurl,
    String tag,
    int likeCounter,
  ) async {
    var documentRef = await collectionreference.add({
      "PostText": title,
      "image": "",
      "username": username,
      "time": time,
      "profileurl": profileurl,
      "tag": tag,
      "likeCounter": likeCounter,
      "likes": [],
      "Save": [],
      "uid": autService.auth.currentUser!.uid
    });
    return Post2(
        DocId: documentRef.id,
        PostText: title,
        image: "",
        username: username,
        time: time,
        profileurl: profileurl,
        tag: tag,
        likeCounter: likeCounter,
        likes: [],
        saves: []);
  }

//veri çekme
  Stream<List<Post2>> getAllPost() {
    var ref = collectionreference
        .orderBy("time", descending: true)
        .snapshots()
        .map((event) => event.docs.map((data) => Post2.fromMap(data)).toList());

    return ref;
  }

  

  //veri silme
  Future<void> deleteData(String docId) async {
    var ref = await collectionreference.doc(docId).delete();
    return ref;
  }

  

// post liked
  likePost(String postId, String uid, List likes) {
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var res;
    try {
      if (likes.contains(uid)) {
        collectionreference.doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        collectionreference.doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return null;
  }

// yorum atma
  Future<String>? postComment(String postId, String title, String username,
      String uid, String profilePicture) async {
    var commentId = const Uuid().v1();
    if (title.isNotEmpty) {
      await collectionreference
          .doc(postId)
          .collection("comment")
          .doc(commentId)
          .set({
        "profilePicture": profilePicture,
        "title": title,
        "username": username,
        "uid": uid,
        "commentId": commentId
      });
    } else {
      Get.snackbar("Hata!", "Lütfen Yazı Yazınız",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING);
    }

    return "1";
  }

  //yorumları çekme
  Stream<List<Comment>> getComment(String postId) {
    var ref = collectionreference
        .doc(postId)
        .collection("comment")
        .snapshots()
        .map((event) =>
            event.docs.map((data) => Comment.fromMap(data)).toList());

    return ref;
  }

// search
  getUsers() async {
    var ref = firestore
        .collection("Person")
        .where("username",
            isGreaterThanOrEqualTo: searchController.searchControl.value.text)
        .get();

    return ref;
  }

  Future<void> takeAndRemoveSave(var postId, List saves, var uid) async {
    try {
      if (saves.contains(uid)) {
        await firestore.collection("Status").doc(postId).update({
          "Save": FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        await firestore.collection("Status").doc(postId).update({
          'Save': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //savelediğin postu alma
  getSavePost() {
    var ref = firestore
        .collection("Status")
        .where("Save", arrayContains: autService.auth.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Post2.fromMap(e)).toList());

    debugPrint(ref.toString());
    return ref;
  }

  //anonim gönderileri çekme

  getAnonymousPost() {
    var ref = firestore
        .collection("Status")
        .where("uid", isEqualTo: autService.auth.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Post2.fromMap(e)).toList());

    debugPrint(ref.toString());
    return ref;
  }

  Stream <List<ProfileModel>> getCurrentData() {
    var ref = firestore
        .collection("Person")
        .where("uid", isEqualTo: autService.auth.currentUser!.uid)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => ProfileModel.fromMap(e)).toList());

    return ref;
  }
}
