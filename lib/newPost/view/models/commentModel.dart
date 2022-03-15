// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String title;
  final String username;
  final String profilePicture;
  final String uid;
  final dynamic commentId;

  Comment({
    required this.title,
    required this.commentId,
    required this.username,
    required this.profilePicture,
    required this.uid,
  });

  factory Comment.fromMap(DocumentSnapshot data) {
    return Comment(
      commentId: data["commentId"],
      username: data["username"],
      title: data["title"],
      uid: data["uid"],
      profilePicture: data["profilePicture"],
    );
  }
}
