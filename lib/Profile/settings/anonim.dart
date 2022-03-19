import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';


class AnonimPage extends StatelessWidget {
  const AnonimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<StatusService>();
    var controller2 = Get.find<AuthService>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: ()=>Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text("Anonim Gönderiler", style: Get.textTheme.labelLarge),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Obx(
        ()=>ListView.builder(
          itemBuilder: (context, index) {
            var data = controller.post7[index];
            return data.username.contains("Psikoz")
                ? CardPost(
                    time: data.time,
                    title: data.PostText,
                    username: data.username,
                    MediaUrl: data.image,
                    OnLong: ()=> Get.to(const ImageZoomOut(),
                  arguments: data.image),
                    profileUrl: data.profileurl,
                    tag: data.tag,
                    postId: data.DocId,
                    UserUid: controller2.auth.currentUser!.uid,
                    likes: data.likes,
                    Saves: data.saves,uid: data.uid,)
                : SizedBox();
                
          },
          itemCount: controller.post7.length,
        ),
      ),
    );
  }
}
