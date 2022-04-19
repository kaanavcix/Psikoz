// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Home/widgets/CommentBottomsheet.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/ShadowConstants.dart';
import 'package:psikoz_me/core/constants/TextThemeConstants.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttericon/octicons_icons.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';

// tamamlanmıştır bazı ufak tefek değişiklikler yapılacaktır
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
      required this.likes,
      required this.Saves,
      required this.uid,
      required this.onTap,
      required this.degree,
      required this.onMessage})
      : super(key: key);

  String title;
  dynamic time;
  String username;
  String MediaUrl;
  Function()? OnLong;
  String profileUrl;
  String tag;
  String postId;
  String UserUid;
  List likes;
  List Saves;
  var uid;
  var degree;
  void Function()? onTap;
  void Function()? onMessage;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var controller3 = Get.find<StatusService>();
    var controller2 = Get.find<AuthService>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 1, right: 1),
      child: Container(
      
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?const Color.fromARGB(255, 0, 0, 0):Colors.white,
              boxShadow: [
                Get.isDarkMode
                    ? ShadowConstants.boxShadow
                    : ShadowConstants.boxShadowDark
              ] ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: username.contains("Psikoz") ? null : onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: username.contains("Psikoz")
                                ? CircleAvatar(
                                    backgroundColor: ThemeConstant.logoMode,
                                    child: SvgPicture.asset(
                                      LoginConstants.LOGO_IMAGE2_SVG,
                                      color: ThemeConstant.textField
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
                                Row(
                                  children: [
                                    Text(
                                      username,
                                      style: LoginConstants.POPPINS_STYLE,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    username.contains("Psikoz")
                                        ? const SizedBox()
                                        : Text(
                                            degree,
                                            style: LoginConstants.POPPINS_STYLE
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12),
                                          ),
                                  ],
                                ),
                                Text(
                                  time.toString(),
                                  style: LoginConstants.POPPINS_STYLE.copyWith(
                                      color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      LikeButton(
                          isLiked: Saves.contains(UserUid) ? true : false,
                          onTap: (isLiked) async {
                            await controller3.takeAndRemoveSave(
                                postId, Saves, UserUid);
                            return null;
                          },
                          likeBuilder: (isLiked) {
                            return Saves.contains(UserUid)
                                ? Icon(
                                    Octicons.saved,
                                    color: ColorPallete.PURPLECOLOR,
                                    size: 18,
                                  )
                                :  Icon(
                                    Octicons.unsaved,
                                    color: ThemeConstant.textFieldEnabeld,
                                    size: 18,
                                  );
                          }),
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                barrierDismissible: true,
                                title: "Daha Fazlası",
                                titleStyle: LoginConstants.NUNITOTEXT_STYLE
                                    .copyWith(fontSize: 14),
                                content: Column(children: [
                                  uid == controller2.auth.currentUser!.uid
                                      ? ListTile(
                                          onTap: () => controller3
                                                  .deleteData(postId)
                                                  .then((value) {
                                                Get.back();
                                                Get.snackbar("Silindi",
                                                    "Postunuz Silindi",
                                                    backgroundColor: Colors.red,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              }),
                                          trailing: const Icon(
                                            Icons.delete,
                                          ),
                                          title: Text(
                                            "Dökümanı Siliniz",
                                            style: LoginConstants
                                                .NUNITOTEXT_STYLE
                                                .copyWith(fontSize: 14),
                                          ))
                                      : const Text(""),
                                  controller.profileModel.first.degree ==
                                          "PsikoExpa"
                                      ? ListTile(
                                          title: Text("Bir Mesaj Gönderin"),
                                          onTap: onMessage,
                                        )
                                      : Text("")
                                ]));
                          },
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    title,
                    style: LoginConstants.POPPINS_STYLE.copyWith(
                        color: ThemeConstant.textField,
                        fontSize: 11,
                        fontWeight: FontWeight.normal),
                    softWrap: true,
                  ),
                ),
                MediaUrl.length < 6
                    ? const SizedBox()
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
                                  color: ColorPallete.BLUECOLOR,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.grey,
                                  size: 25,
                                );
                        }),
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              CommentSheet(
                                snap: postId,
                              ),
                              isScrollControlled:
                                  true); // isScroll kontrolü widgetın sizeını bizim ayarlamamıza yardımcı oluyor
                        },
                        icon: const Icon(
                          MfgLabs.comment,
                          color: Colors.grey,
                          size: 23,
                        )),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          tag,
                          style: LoginConstants.POPPINS_STYLE
                              .copyWith(fontSize: 10, color: ThemeConstant.textField),
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          Elusive.tag,
                          size: 15,
                          color: ColorPallete.SEARCHCOLOR,
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

  Widget BottomSheetDelete(
      HomeController controller, StatusService controller2) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: Get.height * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 1, spreadRadius: 1)
            ]),
        child: Column(children: [
          uid == controller2.autService.auth.currentUser!.uid
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
