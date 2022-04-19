// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';



class ChatModel {
  String docId;
  String name;
  String profileImage;
  String displayMessage;
  
  ChatModel(
      {required this.docId,
      required this.name,
      required this.profileImage,
      required this.displayMessage,
      });

                  


  factory ChatModel.fromMap(DocumentSnapshot data, Profile otherUser,var id) {
    return ChatModel(
        docId: data.id,
        displayMessage: data["displayMessage"],
        profileImage: otherUser.profileImage,
        name: otherUser.username,
        );
  }
}

class MessageModel {
  String chatId;
  String message;
  String senderId;
  dynamic timeStap;
  MessageModel({
    required this.chatId,
    required this.message,
    required this.senderId,
    required this.timeStap,
  });
  factory MessageModel.fromMap(DocumentSnapshot data) {
    return MessageModel(
        chatId: data.id,
        message: data["message"],
        senderId: data["senderId"],
        timeStap: data["timestap"]);
  }
}

