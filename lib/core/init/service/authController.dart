// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:psikoz_me/Main/view/main_page.dart';
import 'package:psikoz_me/core/init/service/stroage_service.dart';
import 'package:psikoz_me/onboard/Login/view/login_screen.dart';

class AuthService extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  late CollectionReference collectionreference;
  var myFallow = [].obs;
  var myUsername = " ".obs;
  var myUserAvatar = "".obs;
  var mySave = [].obs;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _storageService = Get.put(StroageService());

  @override
  void onInit() {
    super.onInit();
    collectionreference = _fireStore.collection("Person");
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _serUserChanges);
  }

  _serUserChanges(User? user) {
    if (user == null) {
      Get.offAll(() => const Login_Screen());
    } else {
      Get.offAll(() => const MainPage());
    }
  }

//Giriş Yap
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error Message", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }

    return null;
  }

  //Çıkış Yap
  signOut() async {
    myUsername.value = "";
    myUserAvatar.value = "";
    debugPrint(myUsername.value);
    debugPrint(myUserAvatar.value);

    var ref = await auth.signOut();
    return ref;
  }

  //kayıt ol

  Future<UserCredential?> createPerson(String username, String email,
      String password, String passwordAgain) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStore.collection("Person").doc(user.user!.uid).set({
        "username": username,
        "Email": email,
        "Image": " ",
        "Fallow": [],
        "uid": user.user!.uid
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }

  Future<UserCredential?> getProfileImage(XFile pickedImage) async {
    var mediaUrl = await _storageService.uploadMedia2(File(pickedImage.path));
    // ignore: unnecessary_null_comparison
    if (mediaUrl == null) {
      mediaUrl == " ";
    }
    final firebaseUser = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    var ref = await _fireStore
        .collection("Person")
        .doc(firebaseUser!.uid)
        .update({"Image": mediaUrl});
    return null;
  }

  Future<UserCredential?> getUserCurrentData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await _fireStore
          .collection("Person")
          .doc(firebaseUser.uid)
          .get()
          .then((ds4) {
        myUsername.value = ds4.data()!["username"];
        myUserAvatar.value =
            ds4.data()!["Image"] ?? "https://picsum.photos/200";
        myFallow.value = ds4.data()!["Fallow"] ?? [];
        //mySave.value = ds4.data()!["Save"] ?? [];
      });
    }
    return null;
  }

  deleteChat(String docId) async {
    await _fireStore.collection("Chat").doc(docId).delete();
    await _fireStore.collection("Chat").doc(docId).collection("Message");
  }
}
