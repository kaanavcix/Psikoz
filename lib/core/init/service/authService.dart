// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:psikoz_me/Main/view/main_page.dart';
import 'package:psikoz_me/core/components/bottomnaav.dart';

import 'package:psikoz_me/core/constants/RouteConstants.dart';
import 'package:psikoz_me/core/init/service/stroageService.dart';
import 'package:psikoz_me/onboard/Login/view/loginscreen.dart';
import 'package:psikoz_me/onboard/Register/view/stepper.dart';

class AuthService extends GetxService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  late CollectionReference collectionreference;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _storageService = Get.find<StroageService>();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _serUserChanges);
  }

  @override
  void onInit() {
    super.onInit();
    collectionreference = _fireStore.collection("Person");
    firebaseUser = Rx<User?>(auth.currentUser);
  }

  _serUserChanges(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginView());
    } else {
      Get.offAll(() =>  MainPage());
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
    var ref = await auth.signOut();
    return ref;
  }

  //kayıt ol

  Future<UserCredential?> createPerson(String username, String email,
      String password, String passwordAgain) async {
    if (username.length >= 4 &&
        GetUtils.isEmail(email) &&
        password == passwordAgain &&
        password.length >= 6) {
      try {
        var user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _fireStore.collection("Person").doc(user.user!.uid).set({
          "username": username,
          "Email": email,
          "Image": " ",
          "Follow": [],
          "uid": user.user!.uid,
          "degree": "PsikoEra",
          "degreeNumber": "1",
          "Following": [],
          "anonim": ""
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
    } else {
      Get.snackbar("HATA", "Hatalı Bilgi Girdiniz",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
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
        .set({"Image": mediaUrl}, SetOptions(merge: true));

    return null;
  }

  deleteChat(String docId) async {
    await _fireStore.collection("Chat").doc(docId).delete();
  }
}
