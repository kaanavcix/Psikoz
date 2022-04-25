// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Home/View/Natificounts.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Home/widgets/listView.dart';
import 'package:psikoz_me/Home/widgets/trendContainer.dart';
import 'package:psikoz_me/Search/view/searchProfile.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/components/vertical_listview.dart';
import 'package:psikoz_me/core/constants/CommonTextConstant.dart';
import 'package:psikoz_me/core/constants/TextThemeConstants.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Get.put(HomeController());
    return Scaffold(
        body: GetBuilder<HomeController>(
          
          builder: (controller) =>  CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [sliverBar(),sliverBox(controller), sliverList()],
            ),
        ));
  }

  Widget sliverList() {
    var controller = Get.find<StatusService>();
    var messageController = Get.find<ChatService>();
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var data = controller.post4[index];
            return CardPost(
                degree: data.degree,
                onTap: () => Get.to(const SearchProfile(), arguments: data.uid),
                OnLong: () =>
                    Get.to(const ImageZoomOut(), arguments: data.image),
                username: data.username,
                title: data.PostText,
                time: data.time,
                MediaUrl: data.image,
                profileUrl: data.profileurl,
                tag: data.tag,
                likes: data.likes,
                UserUid: controller.autService.auth.currentUser!.uid,
                postId: data.DocId,
                Saves: data.saves,
                uid: data.uid,
                onMessage: () async =>
                    await messageController.startConversations(
                        messageController.ilterProfiles(data.uid)));
          },
          childCount: controller.post4.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter sliverBox(HomeController controller) {
    return SliverToBoxAdapter(
      child: VerticalListview(controller: controller,),
      
    );
  }

  SliverAppBar sliverBar() {
    return SliverAppBar(
      elevation: 2,
      expandedHeight: 30,
     
      floating: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(const NatiScreen());
            },
            icon: Icon(
              Icons.notifications,
              
              color: Get.isDarkMode?Colors.white:Colors.black,
            ))
      ],
      snap: false,
      centerTitle: true,
      title: Text(
        CommonTextConstants.ANONIM,
        style: TextThemeConstants.NAMESTYLE,
      ),
    );
  }
}
