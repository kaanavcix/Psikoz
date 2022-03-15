// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StroageService extends GetxController {
  final FirebaseStorage _firebaseStroage = FirebaseStorage.instance;
  final FirebaseStorage _firebaseStroage2 = FirebaseStorage.instance;

  //resim ekleme

  Future<String> uploadMedia(File file) async {
    var UploadTask = _firebaseStroage
        .ref()
        .child("{${DateTime.now().microsecond}.${file.path.split('.').last}")
        .putFile(file);

    UploadTask.snapshotEvents.listen((event) {});

    var stroageRef = await UploadTask;

    return await stroageRef.ref.getDownloadURL();
  }

  Future<String> uploadMedia2(File file) async {
    var UploadTask = _firebaseStroage2
        .ref()
        .child("{${DateTime.now().microsecond}.${file.path.split('.').last}")
        .putFile(file);

    UploadTask.snapshotEvents.listen((event) {});

    var stroageRef = await UploadTask;

    return await stroageRef.ref.getDownloadURL();
  }
}
