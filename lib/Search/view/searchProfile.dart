// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';

import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:psikoz_me/Search/controller/searchProfileController.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:get/get.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class SearchProfile extends StatelessWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchController());
    var data = Get.arguments;
    return Scaffold(
      body: FutureBuilder(
          future: controller.getSearchUser(data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: LinearProgressIndicator(
                color: ColorPallete.BLUECOLOR,
              ));
            } else {
              return profilePage(data);
            }
          }),
    );
  }

  Widget profilePage(var data) {
    return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [profileappbar(data)];
        },
        body: Column(children: [
          Container(
              height: 50,
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey, width: 1))),
              child: Center(
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 15,
                    child: SvgPicture.asset(LoginConstants.LOGO_IMAGE2_SVG,
                        color: ColorPallete.BLUECOLOR)),
              )),
          Expanded(
            child: Obx(() => PostWidget()),
          )
        ]));
  }

  

  Widget profileappbar(var data) {
    var controller2 = Get.find<AuthService>();
    var controller3 = Get.put(SearchController());
    var controller4 = Get.find<StatusService>();
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      expandedHeight: Get.height * 0.47,
      floating: false,
      snap: false,
      elevation: 2,
      flexibleSpace: FlexibleSpaceBar(
        background: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
                child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  )),
            )),
            Obx(() => designProfile(controller3)),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: name(),
              ),
            ),
            const SizedBox(height: 10),
            controller2.auth.currentUser!.uid == data
                ? const SizedBox(height: 0)
                : Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller3.isFollowing.value
                            ? Button(
                                "Takipten Çık",
                                () async {
                                  await controller4.firestore
                                      .collection('Person')
                                      .doc(data)
                                      .update({
                                    'Follow': FieldValue.arrayRemove(
                                        [controller2.auth.currentUser!.uid]),
                                  });
                                  await controller4.firestore
                                      .collection("Person")
                                      .doc(controller2.auth.currentUser!.uid)
                                      .update({
                                    "Following:":
                                        FieldValue.arrayRemove(<String>[data])
                                  });
                                  controller3.isFollowing.toggle();
                                  controller3.followNumber.value--;
                                },
                              )
                            : Button("Takip Et", () async {
                                await controller4.firestore
                                    .collection('Person')
                                    .doc(data)
                                    .update({
                                  'Follow': FieldValue.arrayUnion(
                                      [controller2.auth.currentUser!.uid])
                                });
                                await controller4.firestore
                                    .collection("Person")
                                    .doc(controller2.auth.currentUser!.uid)
                                    .update({
                                  "Following:":
                                      FieldValue.arrayUnion(<String>[data])
                                });
                                controller3.isFollowing.toggle();
                                controller3.followNumber.value++;
                              })
                      ],
                    ),
                  ),
          ],
        )),
      ),
    );
  }

  Row name() {
    var crtl = Get.find<SearchController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        /* SizedBox(
                                width: 20,
                              ), */
        Text(
          crtl.username.value,
          textAlign: TextAlign.start,
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 25,color: Get.isDarkMode ?Colors.white:Colors.black),
        ),
      ],
    );
  }

  Widget designProfile(SearchController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        fallow(),
        const SizedBox(
          width: 10,
        ),
        profileCircle(),
        const SizedBox(
          width: 10,
        ),
        like(controller)
      ],
    );
  }

  Column like(SearchController controller) {
    final children = <Widget>[];
    final children2 = <Widget>[];
    var num = int.parse(controller.degreeNumber.value);

    for (var i = 1; i < num; i++) {
      if (i <= 2) {
        children.add(Icon(FontAwesome5.star, size: 12));
      } else if (i < 6) {
        children2.add(Icon(FontAwesome5.star, size: 12));
      }
    }
    children.add(Icon(FontAwesome5.star, size: 12));
    return Column(
      children: [
        Row(children: children2),
        Row(children: children),
        Text(
          "Derece",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 12,color:Get.isDarkMode ?Colors.white:Colors.black),
        ),
      ],
    );
  }

  Column fallow() {
    var controller = Get.find<SearchController>();
    return Column(children: [
      Text(
        "${controller.followNumber.value}",
        style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
            .copyWith(fontSize: 14, color: Get.isDarkMode ?Colors.white:Colors.black),
      ),
      Text(
        "Takipçi",
        style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
            .copyWith(fontSize: 12, color: Get.isDarkMode ?Colors.white:Colors.black),
      )
    ]);
  }

  Widget profileCircle() {
    var controller2 = Get.find<SearchController>();

    return Obx(() => CircleAvatar(
        radius: 75, backgroundImage: NetworkImage(controller2.image.value)));
  }

  Widget Button(String text, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.7,
        height: 40,
        child: Center(
            child: Center(
          child: Text(
            text,
            style: ProfileConstants.BUTTONSTYLE,
          ),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: ColorPallete.LINEARGRADIENT_COLOR,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
           
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 0.5, spreadRadius: 0.4)
            ]),
      ),
    );
  }

  Widget PostWidget() {
    var controller = Get.put(SearchProfileController());
    var controller2 = Get.put(AuthService());
    var messageController = Get.find<ChatService>();
    return ListView.builder(
      itemCount: controller.searchPost.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Obx((() {
          var Data = controller.searchPost[index];
          return CardPost(
            onMessage: () => messageController
                .startConversations(messageController.ilterProfiles(Data.uid)),
            degree: Data.degree,
            onTap: () => Get.to(const SearchProfile(), arguments: Data.uid),
            Saves: Data.saves,
            time: Data.time,
            title: Data.PostText,
            username: Data.username,
            MediaUrl: Data.image,
            OnLong: () => Get.to(const ImageZoomOut(), arguments: Data.image),
            profileUrl: Data.profileurl,
            tag: Data.tag,
            likes: Data.likes,
            UserUid: controller2.auth.currentUser!.uid,
            postId: Data.DocId,
            uid: Data.uid,
          );
        }));
      },
    );
  }
}
