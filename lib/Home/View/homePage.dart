// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Home/View/Natificounts.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Home/widgets/listView.dart';
import 'package:psikoz_me/Home/widgets/trendContainer.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/core/constants/Homeconstants.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [sliverBar(), sliverBox(), Obx(() => sliverList())],
    ));
  }

  SliverList sliverList() {
    var controller = Get.find<StatusService>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CardPost(
            OnLong: () => Get.to(const ImageZoomOut(),
                arguments: controller.post4[index].image),
            username: controller.post4[index].username,
            title: controller.post4[index].PostText,
            time: controller.post4[index].time,
            MediaUrl: controller.post4[index].image,
            profileUrl: controller.post4[index].profileurl,
            tag: controller.post4[index].tag,
            likes: controller.post4[index].likes,
            UserUid: controller.autService.auth.currentUser!.uid,
            postId: controller.post4[index].DocId,
            Saves: controller.post4[index].saves,
          );
        },
        childCount: controller.post4.length,
      ),
    );
  }

  SliverToBoxAdapter sliverBox() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:const [
                  TrendContainer(),
                   ListViewWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar sliverBar() {
    return SliverAppBar(
      elevation: 2,
      expandedHeight: 30,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      floating: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(const NatiScreen());
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ))
      ],
      snap: false,
      centerTitle: true,
      title: Text(
        HomeConstant.APP_NAME,
        style: HomeConstant.NAMESTYLE,
      ),
    );
  }
}

