import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Message/view/model/chatModel.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';
import 'package:psikoz_me/Profile/view/model/profile_model.dart';

import 'package:psikoz_me/core/init/service/AuthService.dart';

import 'package:psikoz_me/core/init/service/stroageService.dart';
import 'package:psikoz_me/newPost/view/models/addmodel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:psikoz_me/newPost/view/models/commentModel.dart';

class StatusService extends GetxService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _storageService = Get.find<StroageService>();
  final autService = Get.find<AuthService>();
  var ref2;
  late CollectionReference collectionreference;
  late CollectionReference collectionreferenceComment;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var uid = "".obs;
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
    dynamic time,
    String profileurl,
    String tag,
    int likeCounter,
    String degree,
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
      "uid": autService.auth.currentUser!.uid,
      "degree": degree
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
        saves: [],
        degree: degree);
  }

  // sadece text
  Future<Post2> addText(
    String title,
    String username,
    dynamic time,
    String profileurl,
    String tag,
    int likeCounter,
    String degree,
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
      "uid": autService.auth.currentUser!.uid,
      "degree": degree
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
        saves: [],
        degree: degree);
  }

//veri çekme
  getAllPost() {
    var ref2 =
        collectionreference.get();
    
    var ref = collectionreference
        .orderBy("time", descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((data) => Post2.fromMap(
                  data,
                ))
            .toList());

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
          snackPosition: SnackPosition.TOP);
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

  Future<void> takeAndRemoveSave(var postId, List saves, var uid) async {
    try {
      if (saves.contains(uid)) {
        await firestore.collection("Status").doc(postId).update({
          "Save": FieldValue.arrayRemove([uid]) // array içine veri silme
        });
      } else {
        // else we need to add uid to the likes array
        await firestore.collection("Status").doc(postId).update({
          'Save': FieldValue.arrayUnion([uid]) // array içinde veri ekleme
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
        .where("Save",
            arrayContains: autService.auth.currentUser!
                .uid) // listenin içinde içeriyorsa eğer çekiyor
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

  Stream<List<ProfileModel2>> getCurrentData() {
    var ref = firestore
        .collection("Person")
        .where("uid", isEqualTo: autService.auth.currentUser!.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProfileModel2.fromMap(e)).toList());

    return ref;
  }

  //şifremi unuttum

  Future<void>? resetPasswordSendEmailAdress(String email) async {
    try {
      var ref = await autService.auth.sendPasswordResetEmail(email: email);

      return ref;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("ERROR", e.message!, backgroundColor: Colors.red);
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("ERROR", e.toString(), backgroundColor: Colors.red);
    }
  }

  VerifyCodeForResetPassword() {}

  setProfile(String name) async {
    // random anonim isim ataması
    Random random = Random();
    int randomNumber = random.nextInt(10000);

    var string = "$name$randomNumber";

    await firestore
        .collection("Person")
        .doc(autService.auth.currentUser!.uid)
        .set({"anonim": string}, SetOptions(merge: true));// bunun true olması overwrite etmesine yarıyor merge true !!!
  }
}
