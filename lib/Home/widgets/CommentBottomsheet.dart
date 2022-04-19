// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/widgets/bottomComment.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/components/card/comment_card.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class CommentSheet extends StatelessWidget {
  CommentSheet({required this.snap, Key? key}) : super(key: key);

  dynamic snap;

  var controller = Get.find<StatusService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      decoration:  BoxDecoration(
          color: ThemeConstant.logoMode
        ),
      child: Column(children: [
        const Icon(Typicons.minus,color: Colors.white,),
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
                return Center(
                  child: LinearProgressIndicator(color: ColorPallete.BLUECOLOR,),
                );
              }
              if(snapshot.connectionState==ConnectionState.none) Center(child: Text("İnternet Hatası"),);
               return snapshot.data!.docs.length!=0? ListView.builder(
                 physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CommentCard(
                    snap: snapshot.data!.docs[index],
                  );
                },
                itemCount: snapshot.data!.docs.length,
              ): Center(child: Text("İlk yorum yapan sen ol",style: Get.theme.
              textTheme.bodyMedium!.copyWith(color: ThemeConstant.textField),),);
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
