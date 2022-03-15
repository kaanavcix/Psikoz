// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/init/service/status_service.dart';

class SearchDetail extends StatelessWidget {
  const SearchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Data = Get.arguments;
    var controller = Get.find<SearchController>();
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          expandedHeight: Get.height * 0.25,
          flexibleSpace: FlexibleSpaceBar(
            background: SvgPicture.asset(
              controller.physcologyObject[Data].imageAsset,
            ),
            title: Text(controller.physcologyObject[Data].name,
                style: Login_Constants.NUNITOTEXT_STYLE_BOLD
                    .copyWith(color: Colors.black)),
          ),
        ),
        sliverList(Data)
      ]),
    );
  }

  SliverList sliverList(int data) {
    var controller = Get.put(StatusService());
    var controller5 = Get.find<SearchController>();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return (controller.post4[index].tag ==
                  controller5.physcologyObject[data].name)
              ? CardPost(
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
           
                )
              : const SizedBox(height: 0);
        },
        childCount: controller.post4.length,
      ),
    );
  }
}
