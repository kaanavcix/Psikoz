import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;
  final String username;
  final String email;
  final dynamic fallow;
  final String image;
  final String degree;
  final String uid;
  final dynamic degreeNumber;

  ProfileModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.fallow,
      required this.image,
      required this.uid,
      required this.degree,required this.degreeNumber});

  factory ProfileModel.fromMap(DocumentSnapshot snapshot) {
    return ProfileModel(
        id: snapshot.id,
        username: snapshot["username"],
        email: snapshot["Email"],
        fallow: snapshot["Fallow"],
        image: snapshot["Image"],
        degree: snapshot["degree"],
        uid: snapshot["uid"],
        degreeNumber: snapshot["degreeNumber"]);
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, Email: $email, Fallow: $fallow, Image: $image, uid: $uid,$degree : degree)';
  }
}
