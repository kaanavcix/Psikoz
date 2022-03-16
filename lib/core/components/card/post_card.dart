// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Home/widgets/CommentBottomsheet.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

// devam edilecektir
class CardPost extends StatelessWidget {
  CardPost(
      {Key? key,
      required this.time,
      required this.title,
      required this.username,
      required this.MediaUrl,
      required this.OnLong,
      required this.profileUrl,
      required this.tag,
      required this.postId,
      required this.UserUid,
      required this.likes, required this.Saves})
      : super(key: key);

  String title;
  String time;
  String username;
  String MediaUrl;
  Function()? OnLong;
  String profileUrl;
  String tag;
  String postId;
  String UserUid;
  List likes;
  List Saves;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var controller3 = Get.put(StatusService());
    var controller2 = Get.find<AuthService>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(spreadRadius: 0.4, blurRadius: 1, color: Colors.white),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white38,

            //border: Border.all(color: Colors.black, width: 0.5)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: username.contains("Psikoz")
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                Login_Constants.LOGO_IMAGE2_SVG,
                              ))
                          : CircleAvatar(
                              backgroundImage: profileUrl == " "
                                  ? const NetworkImage(
                                      "https://picsum.photos/200")
                                  : NetworkImage(profileUrl)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username,
                              style: Login_Constants.NUNITOTEXT_STYLE),
                          Text(
                            time,
                            style: Login_Constants.NUNITOTEXT_STYLE_W700
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                   
                          LikeButton(
                        isLiked: Saves.contains(UserUid) ? true : false,
                        onTap: (isLiked) async {
                           await controller3.takeAndRemoveSave(postId,Saves,UserUid);
                          return null;
                        },
                       
                        likeBuilder: (isLiked) {
                          return Saves.contains(UserUid)
                              ? Icon(
                                  Icons.save,
                                  color: BottomBar_Constant.COLORBLUEKA,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.save_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                );
                        }),
                     
                    
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              BottomSheetDelete(controller2, controller3));
                        },
                        icon: const Icon(Icons.more_horiz_rounded))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    title,
                    softWrap: true,
                  ),
                ),
                MediaUrl.length < 6
                    ? Container(
                        color: Colors.transparent,
                      )
                    : GestureDetector(
                        onLongPress: OnLong,
                        child: Hero(
                            tag: MediaUrl,
                            child: Image.network(
                              MediaUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitWidth,
                            ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    LikeButton(
                        isLiked: likes.contains(UserUid) ? true : false,
                        onTap: (isLiked) async {
                          controller3.likePost(postId, UserUid, likes);
                          return null;
                        },
                        likeCount: likes.length,
                        likeBuilder: (isLiked) {
                          return likes.contains(UserUid)
                              ? Icon(
                                  Icons.favorite,
                                  color: BottomBar_Constant.COLORBLUEKA,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                );
                        }),
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              CommentSheet(
                                snap: postId,
                              ),
                              isScrollControlled: true);
                        },
                        icon: const Icon(
                          MfgLabs.comment,
                          color: Colors.grey,
                        )),
                    const Spacer(),
                    Row(
                      children: [
                        Text(tag),
                        const SizedBox(width: 3),
                        const Icon(
                          Elusive.tag,
                          size: 15,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget BottomSheetDelete(AuthService controller, StatusService controller2) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.3, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 1, spreadRadius: 1)
            ]),
        child: Column(children: [
          username == controller.myUsername.value
              ? ListTile(
                  onTap: () => controller2.deleteData(postId).then((value) {
                        Get.back();
                        Get.snackbar("Silindi", "Postunuz Silindi",
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM);
                      }),
                  trailing: const Icon(
                    Icons.delete,
                  ),
                  title: const Text("Dökümanı Siliniz"))
              : const Text("data")
        ]),
      ),
    );
  }
}
