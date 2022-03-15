// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/widgets/bottomComment.dart';
import 'package:psikoz_me/core/components/card/comment_card.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class CommentSheet extends StatelessWidget {
  CommentSheet({required this.snap, Key? key}) : super(key: key);

  dynamic snap;

  var controller = Get.find<StatusService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(children: [
        const Icon(FontAwesome5.grip_lines),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Status")
                .doc(snap)
                .collection("comment")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return CommentCard(
                    snap: snapshot.data!.docs[index],
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomComment(
            snap: snap,
          ),
        )
      ]),
    );
  }
}
