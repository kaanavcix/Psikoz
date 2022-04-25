// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/homePage.dart';
import 'package:psikoz_me/Message/controller/messageController.dart';

import 'package:psikoz_me/Message/view/model/chatModel.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class CheatDetail extends StatefulWidget {
  CheatDetail({required this.userId, required this.chatModel, Key? key})
      : super(key: key);
  final dynamic userId;
  ChatModel chatModel;

  @override
  State<CheatDetail> createState() => _CheatDetailState();
}

class _CheatDetailState extends State<CheatDetail> {
  var controller = Get.find<StatusService>();
  var controller2 = Get.put(MessageController());

  late CollectionReference _ref;
  @override
  void initState() {
    super.initState();
    _ref = controller.firestore
        .collection("Chat/${widget.chatModel.docId}/messages");
    //debugPrint(widget.chatModel.docId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Get.height * 0.15,
          elevation: 8,
          backgroundColor: ThemeConstant.logoMode,
         
          title: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.chatModel.profileImage),
              backgroundColor: ColorPallete.BLUECOLOR
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.chatModel.name,
              style: TextStyle(color:ThemeConstant.mode)
            ),
            const Spacer(),
          ]),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream:
                      _ref.orderBy("timestamp", descending: false).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                        children: snapshot.data!.docs
                            .map<Widget>((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      return ListTile(
                        title: Align(
                            alignment: widget.userId != data["senderId"]
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              width: Get.width * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  data["message"],
                                  style: GoogleFonts.firaSans(
                                      color: widget.userId == data["senderId"]
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                gradient: widget.userId != data["senderId"]
                                    ? LinearGradient(
                                        colors: ColorPallete
                                            .LINEARGRADIENT_COLOR,
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                      )
                                    : const LinearGradient(colors: [
                                        Color.fromRGBO(234, 236, 242, 1.0),
                                        Color.fromRGBO(234, 236, 242, 1.0)
                                      ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      );
                    }).toList());
                  }),
            ),
            Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextField(
                                controller: controller2.editingController,
                                cursorColor: ColorPallete.BLUECOLOR,
                                decoration: const InputDecoration(
                                    hintText: "Please Write Here :::..",
                                    disabledBorder: InputBorder.none
                                    ,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none
                                    ))
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                        onTap: () async {
                          //debugPrint(widget.chatModel.docId.toString());
                         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                          await controller.firestore
                              .collection(
                                  "Chat/${widget.chatModel.docId}/messages")
                              .add({
                            "senderId": widget.userId,
                            "message": controller2.editingController.text,
                            "timestamp": DateTime.now()
                          });
                          controller2.editingController.text = "";
                        },
                        child: const Icon(
                          Icons.send,
                          size: 28,
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
