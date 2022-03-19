// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Post2 {
  final String DocId;
  final String PostText;
  final String image;
  final String username;
  final String time;
  final String profileurl;
  final String tag;
  final int likeCounter;
  final dynamic likes;
  final dynamic saves;
  final dynamic uid;

  Post2(
      {required this.DocId,
      required this.PostText,
      required this.image,
      required this.username,
      required this.time,
      required this.profileurl,
      required this.tag,
      required this.likeCounter,
      required this.likes, required this.saves,this.uid});

  factory Post2.fromMap(DocumentSnapshot data,) {
    return Post2(
        DocId: data.id,
        PostText: data["PostText"],
        image: data["image"],
        username: data["username"],
        time: data["time"],
        profileurl: data["profileurl"],
        tag: data["tag"],
        likeCounter: data["likeCounter"],
        likes: data["likes"],
        saves: data["Save"],uid: data["uid"]);
  }
}

class Post3 {
  final String DocId;
  final String PostText;
  final String image;
  final String username;
  final String time;
  final String profileurl;
  final String tag;
  final int likeCounter;
  final dynamic likes;
    final dynamic saves;
      final dynamic uid;



  Post3(
      {required this.DocId,
      required this.PostText,
      required this.image,
      required this.username,
      required this.time,
      required this.profileurl,
      required this.tag,
      required this.likeCounter,
      required this.likes
      ,required this.saves,this.uid});

  factory Post3.fromMap(DocumentSnapshot data) {
    return Post3(
        DocId: data.id,
        PostText: data["PostText"],
        image: data["image"],
        username: data["username"],
        time: data["time"],
        profileurl: data["profileurl"],
        tag: data["tag"],
        likeCounter: data["likeCounter"],
        likes: data["likes"]
        ,saves: data["Save"],uid: data["uid"]);
  }
}
