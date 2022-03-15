import 'dart:io';
import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Profile/controller/profileController.dart';
import 'package:psikoz_me/Profile/view/settings.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:psikoz_me/core/init/service/authController.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

//bunları parçalamayı unutma ve backend state management
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(StatusService());
    return Scaffold(
      //appBar: TopAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: controller.getUserCurrentData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: LinearProgressIndicator(
                color: BottomBar_Constant.COLORBLUEKA,
              ));
            } else {
              return profilePage();
            }
          }),
    );
  }

  DefaultTabController profilePage() {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [profileappbar()];
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
                    children: [Obx(() => postWidget()), saveWidget()]),
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
          Tab(
           icon: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: SvgPicture.asset(
                  Login_Constants.DAILYLOGO,
                  color: BottomBar_Constant.COLORGREENKA,
                )),
          )
        ]);
  }

  SliverAppBar profileappbar() {
    var controller2 = Get.find<AuthService>();

    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.45,
      backgroundColor: Search_Constant.COLORBLUEKA,
      floating: false,
      snap: false,
      elevation: 2,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(const SettingsScreen());
                          debugPrint(controller2.myUserAvatar.value.toString());
                        },
                        icon: const Icon(Icons.more_vert))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                designProfile(),
                const SizedBox(height: 20),
                Obx(
                  () => name(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [],
                )
              ],
            )),
      ),
    );
  }

  Row name() {
    var controller = Get.put(AuthService());
    //debugPrint("${controller.myUsername.value} haadi bakalım demet akalın");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        /* SizedBox(
                                width: 20,
                              ), */
        Text(
          controller.myUsername.value,
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
    var controller = Get.find<AuthService>();
    return Column(children: [
      Text("${controller.myFallow.length}",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK),
      Text(
        "Takipçi",
        style:
            ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK.copyWith(fontSize: 12),
      )
    ]);
  }

  Widget profileCircle() {
    var controller = Get.put(ProfileController());
    var controller2 = Get.find<AuthService>();
    return GestureDetector(
      onLongPress: () =>
          Get.bottomSheet(bottomSheet(controller)).then((value) => Get.back()),
      child: Obx(() => CircleAvatar(
          radius: 75,
          child: controller.selectedImage.value == null
              ? CircleAvatar(
                  radius: 75,
                  child: CircleAvatar(
                      radius: 75,
                      child: controller2.myUserAvatar.value == " "
                          ? CircleAvatar(
                              child: SvgPicture.asset(
                                Login_Constants.LOGO_IMAGE2_SVG,
                                height: 150,
                                width: 150,
                              ),
                            )
                          : CircleAvatar(
                              radius: 75,
                              backgroundImage: NetworkImage(
                                  controller2.myUserAvatar.value))))
              : CircleAvatar(
                  radius: 75,
                  backgroundImage: FileImage(
                    File(controller.secondPath.value),
                  )))),
    );
  }

  

  Container profilePicture() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        child: SvgPicture.asset(Login_Constants.LOGO_IMAGE2_SVG, height: 100),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.white, blurRadius: 0.4, spreadRadius: 1)
          ],
        ),
      ),
    );
  }

  

  Widget saveWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.abc_sharp),
        onPressed: () {},
      ),
    );
  }

  Widget postWidget() {
    var controller = Get.put(StatusService());
    debugPrint(controller.post5.length.toString());

    return ListView.separated(
      itemCount: controller.post5.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Obx((() {
          var data = controller.post5[index];

          return CardPost(
            time: data.time,
            title: data.PostText,
            username: data.username,
            MediaUrl: data.image,
            OnLong: () => Get.to(const ImageZoomOut(), arguments: data.image),
            profileUrl: data.profileurl,
            tag: data.tag,
            likes: data.likes,
            UserUid: controller.autService.auth.currentUser!.uid,
            postId: data.DocId,
          );
        }));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  Container bottomSheet(ProfileController controller) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(children: [
          ListTile(
            onTap: (() => controller
                .getImage(ImageSource.camera)
                .then((value) => Get.back())),
            leading: const Icon(Icons.camera),
            title: const Text("Kamera"),
          ),
          ListTile(
            onTap: (() => controller
                .getImage(ImageSource.gallery)
                .then((value) => Get.back())),
            leading: const Icon(Icons.photo_album),
            title: const Text("Album"),
          ),
        ]),
      ),
    );
  }
}
