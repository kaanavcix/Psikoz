import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel2 {
  final String id;
  final String username;
  final String email;
  final dynamic follow;
  final String image;
  final String degree;
  final String uid;
  final dynamic degreeNumber;
  final dynamic following;
  final String anonim;

  ProfileModel2(
      {required this.id,
      required this.username,
      required this.email,
      required this.follow,
      required this.image,
      required this.uid,
      required this.degree,
      required this.degreeNumber,
      this.following,required this.anonim});

  factory ProfileModel2.fromMap(DocumentSnapshot snapshot) {
    return ProfileModel2(
        id: snapshot.id,
        username: snapshot["username"],
        email: snapshot["Email"],
        follow: snapshot["Follow"],
        image: snapshot["Image"],
        degree: snapshot["degree"],
        uid: snapshot["uid"],
        degreeNumber: snapshot["degreeNumber"],
        following: snapshot["Following"],anonim: snapshot["anonim"]);
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, Email: $email, Fallow: $follow, Image: $image, uid: $uid,$degree : degree)';
  }
}
