import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;
  final String username;
  final String Email;
  final dynamic Fallow;
  final String Image;
  final String uid;

  ProfileModel(
      {required this.id,
      required this.username,
      required this.Email,
      required this.Fallow,
      required this.Image,
      required this.uid});

  factory ProfileModel.fromMap(DocumentSnapshot snapshot) {
    return ProfileModel(
        id: snapshot.id,
        username: snapshot["username"],
        Email: snapshot["Email"],
        Fallow: snapshot["Fallow"],
        Image: snapshot["Image"],
        uid: snapshot["uid"]);
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, Email: $Email, Fallow: $Fallow, Image: $Image, uid: $uid)';
  }
}
