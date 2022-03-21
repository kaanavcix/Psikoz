import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
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
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

//bunları parçalamayı unutma ve backend state management
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: TopAppBar(),
        backgroundColor: Colors.white,
        body: profilePage());
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
                    children: [
                      Obx(() => postWidget()),
                      Obx(() => saveWidget())
                    ]),
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
              icon: Icon(
            Octicons.saved,
            color: Search_Constant.COLORGREENKA,
          ))
        ]);
  }

  SliverAppBar profileappbar() {
    var controller = Get.find<HomeController>();

    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.45,
      backgroundColor: BottomBar_Constant.COLORBLUEKA,
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
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          },
                          icon: const Icon(Icons.more_vert))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  designProfile(controller),
                  const SizedBox(height: 20),
                  name(),
                  Text(
                    controller.profileModel.first.degree,
                    style: Login_Constants.NUNITOTEXT_STYLE
                        .copyWith(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Row name() {
    var controller = Get.find<HomeController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.profileModel.first.username,
          textAlign: TextAlign.start,
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 25),
        ),
      ],
    );
  }

  Widget designProfile(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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

  Column like(HomeController controller) {
    final children = <Widget>[];
    final children2 = <Widget>[];
    var num = int.parse(controller.profileModel.first.degreeNumber);

    for (var i = 1; i < num; i++) {
      if (i <= 2) {
        children.add(Icon(FontAwesome5.star, size: 14));
      } else if (i < 6) {
        children2.add(Icon(FontAwesome5.star, size: 14));
      }
    }
    children.add(Icon(FontAwesome5.star, size: 14));
    return Column(
      children: [
        Row(children: children),
        Row(children: children2),
        Text(
          "Derece",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Column fallow() {
    var controller = Get.find<HomeController>();
    return Column(children: [
      Text("${controller.profileModel.first.fallow.length}",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK.copyWith(fontSize: 14)),
      Text(
        "Takipçi",
        style:
            ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK.copyWith(fontSize: 12),
      )
    ]);
  }

  Widget profileCircle() {
    var controller = Get.put(ProfileController());
    var controller2 = Get.find<HomeController>();
    return GestureDetector(
        onLongPress: () => Get.bottomSheet(bottomSheet(controller))
            .then((value) => Get.back()),
        child: Obx(() => CircleAvatar(
            radius: 75,
            child: controller2.profileModel.first.image == " "
                ? CircleAvatar(
                    radius: 75,
                    child: SvgPicture.asset(Login_Constants.LOGO_IMAGE2_SVG),
                  )
                : CircleAvatar(
                    radius: 75,
                    backgroundImage:
                        NetworkImage(controller2.profileModel.first.image)))));
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
    var controller = Get.find<StatusService>();
    var controller2 = Get.find<AuthService>();

    return ListView.builder(
      itemBuilder: (context, index) {
        var data = controller.post6[index];

        return CardPost(
          time: data.time,
          title: data.PostText,
          username: data.username,
          MediaUrl: data.image,
          OnLong: () => Get.to(const ImageZoomOut(), arguments: data.image),
          profileUrl: data.profileurl,
          tag: data.tag,
          postId: data.DocId,
          UserUid: controller2.auth.currentUser!.uid,
          likes: data.likes,
          Saves: data.saves,
          uid: data.uid,
        );
      },
      itemCount: controller.post6.length,
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
            Saves: data.saves,
            uid: data.uid,
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
