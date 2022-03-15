import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String docId;
  String username;
  String profileImage;

  Profile({
    required this.docId,
    required this.username,
    required this.profileImage,
  });
  factory Profile.fromMap(DocumentSnapshot data) {
    return Profile(
      docId: data.id,
      username: data["username"],
      profileImage: data["Image"] ?? "https://picsum.photos/200",
    );
  }
}
