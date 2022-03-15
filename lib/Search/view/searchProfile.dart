// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';

import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:psikoz_me/Search/controller/searchProfileController.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:get/get.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchProfile extends StatelessWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchController());
    var data = Get.arguments;
    return Scaffold(
      //appBar: TopAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: controller.getSearchUser(data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: LinearProgressIndicator(
                color: BottomBar_Constant.COLORBLUEKA,
              ));
            } else {
              return profilePage(data);
            }
          }),
    );
  }

  DefaultTabController profilePage(var data) {
    return DefaultTabController(
        length: 1,
        child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [profileappbar(data)];
            },
            body: Column(children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey, width: 1))),
                child: tabTwoItem(),
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [Obx(() => PostWidget())]),
              )
            ])));
  }

  TabBar tabTwoItem() {
    return TabBar(
        indicator: BoxDecoration(border: Border.all(style: BorderStyle.none)),
        indicatorColor: Colors.black,
        indicatorPadding: const EdgeInsets.all(10),
        tabs: [
          Tab(
            icon: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: SvgPicture.asset(
                  Login_Constants.LOGO_IMAGE2_SVG,
                  color: BottomBar_Constant.COLORBLUEKA,
                )),
          ),
        ]);
  }

  SliverAppBar profileappbar(var data) {
    var controller2 = Get.find<AuthService>();
    var controller3 = Get.put(SearchController());
    var controller4 = Get.find<StatusService>();
    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.44,
      backgroundColor: Search_Constant.COLORBLUEKA,
      floating: false,
      snap: false,
      elevation: 2,
      flexibleSpace: FlexibleSpaceBar(
        background: 
           Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => designProfile()),
                  const SizedBox(height: 20),
                  Obx(
                    () => name(),
                  ),
                  const SizedBox(height:10),
                  controller2.auth.currentUser!.uid == data
                      ? const SizedBox(height: 0)
                      : Obx(
                        () =>  Row(
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
                                          'Fallow': FieldValue.arrayRemove(
                                              [controller2.auth.currentUser!.uid])
                                        });
                                        controller3.isFollowing.toggle();
                                        controller3.fallowNumber.value--;
                                      },
                                    )
                                  : Button("Takip Et", () async {
                                      await controller4.firestore
                                          .collection('Person')
                                          .doc(data)
                                          .update({
                                        'Fallow': FieldValue.arrayUnion(
                                            [controller2.auth.currentUser!.uid])
                                      });
                                      controller3.isFollowing.toggle();
                                      controller3.fallowNumber.value++;
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
              .copyWith(fontSize: 25),
        ),
      ],
    );
  }

  Widget designProfile() {
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
        trend()
      ],
    );
  }

  Column trend() {
    return Column(
      children: [
        Text("0", style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK),
        Text(
          "Beğeni",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 16),
        ),
      ],
    );
  }

  Column fallow() {
    var controller = Get.find<SearchController>();
    return Column(children: [
      Text("${controller.fallowNumber.value}",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK),
      Text(
        "Takipçi",
        style:
            ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK.copyWith(fontSize: 12),
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
        width: Get.width * 0.9,
        height: 40,
        child: Center(
            child: Center(
          child: Text(
            text,
            style: ProfileConstants.BUTTONSTYLE,
          ),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: BottomBar_Constant.LINEARGRADIENT_COLOR,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            //color: const Color.fromRGBO(47, 187, 240, 1.0),
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 0.5, spreadRadius: 0.4)
            ]),
      ),
    );
  }

  Widget PostWidget() {
    var controller = Get.put(SearchProfileController());
    var controller2 = Get.put(AuthService());
    debugPrint(controller.searchPost.length.toString());

    return ListView.separated(
      itemCount: controller.searchPost.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Obx((() {
          var Data = controller.searchPost[index];
          return CardPost(
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
          );
        }));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
