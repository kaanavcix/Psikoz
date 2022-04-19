import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Profile/controller/profileController.dart';
import 'package:psikoz_me/Profile/view/settings.dart';
import 'package:psikoz_me/Search/view/searchProfile.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/CommonTextConstant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/core/theme/color_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

//bunları parçalamayı unutma ve backend state management
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: profilePage());
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

  Widget tabTwoItem() {
    return TabBar(
        labelColor: Colors.white,
        indicator: BoxDecoration(border: Border.all(style: BorderStyle.none)),
        indicatorColor: Colors.black,
        //indicatorPadding: const EdgeInsets.all(10),
        tabs: [
          Tab(
            icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 15,
                child: SvgPicture.asset(LoginConstants.LOGO_IMAGE2_SVG,
                    color: ColorPallete.BLUECOLOR)),
          ),
          Tab(icon: Icon(Octicons.saved, color: ColorPallete.PURPLECOLOR))
        ]);
  }

  SliverAppBar profileappbar() {
    var controller = Get.find<HomeController>();

    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.45,
      floating: false,
      snap: false,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode?AppColor.bodyColorDark: Colors.white,
            ),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Get.to(const SettingsScreen());
                          },
                          icon:  Icon(
                            Icons.more_vert,
                            color: ThemeConstant.textField,
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  designProfile(controller),
                  const SizedBox(height: 20),
                  name(),
                  Text(
                    controller.profileModel.first.degree,
                    style: LoginConstants.NUNITOTEXT_STYLE
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
              .copyWith(fontSize: 25, color: ThemeConstant.textField),
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
          width: 8,
        ),
        profileCircle(),
        const SizedBox(
          width: 8,
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
        children.add(
            Icon(FontAwesome5.star, color: ThemeConstant.textField, size: 12));
      } else if (i < 6) {
        children2.add(
            Icon(FontAwesome5.star, color: ThemeConstant.textField, size: 12));
      }
    }
    children
        .add(Icon(FontAwesome5.star, color: ThemeConstant.textField, size: 12));
    return Column(
      children: [
        Row(children: children2),
        Row(children: children),
        Text(
          "Derece",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 12, color: ThemeConstant.textField),
        ),
      ],
    );
  }

  Column fallow() {
    var controller = Get.find<HomeController>();
    return Column(children: [
      Text("${controller.profileModel.first.follow.length}",
          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
              .copyWith(fontSize: 14, color: ThemeConstant.textField)),
      Text(
        CommonTextConstants.TAKIPCI,
        style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK
            .copyWith(fontSize: 12, color: ThemeConstant.textField),
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
                    child: SvgPicture.asset(LoginConstants.LOGO_IMAGE2_SVG),
                  )
                : CircleAvatar(
                    radius: 75,
                    backgroundImage:
                        NetworkImage(controller2.profileModel.first.image)))));
  }

  Widget saveWidget() {
    var controller = Get.find<StatusService>();
    var controller2 = Get.find<AuthService>();
    var messageController = Get.find<ChatService>();
    return ListView.builder(
      itemBuilder: (context, index) {
        var data = controller.post6[index];

        return CardPost(
          onMessage: () => messageController
              .startConversations(messageController.ilterProfiles(data.uid)),
          degree: data.degree,
          onTap: () => Get.to(
            const SearchProfile(),
            arguments: data.uid,
          ),
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
    var messageController = Get.find<ChatService>();
    return ListView.builder(
      itemCount: controller.post5.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Obx((() {
          var data = controller.post5[index];

          return CardPost(
            onMessage: () => messageController
                .startConversations(messageController.ilterProfiles(data.uid)),
            degree: data.degree,
            onTap: () => Get.to(
              const SearchProfile(),
              arguments: data.uid,
            ),
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
    );
  }

  Container bottomSheet(ProfileController controller) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: ThemeConstant.logoMode,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.linear_scale_outlined),
          ), // ayarlıcam
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
          controller.controllerd.profileModel.first.image != " "
              ? ListTile(
                  onTap: () => controller.controller2.firestore
                      .collection("Person")
                      .doc(controller.controller.auth.currentUser!.uid)
                      .set({"Image": " "}, SetOptions(merge: true)).then(
                          (value) => Get.back()),
                  leading: const Icon(Icons.delete),
                  title: const Text("Kaldır"))
              : const SizedBox()
        ]),
      ),
    );
  }
}
