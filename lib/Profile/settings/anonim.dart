import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/View/image_zoomout.dart';
import 'package:psikoz_me/Search/view/searchProfile.dart';
import 'package:psikoz_me/core/components/card/post_card.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';


class AnonimPage extends StatelessWidget {
  const AnonimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<StatusService>();
    var controller2 = Get.find<AuthService>();
var messageController = Get.find<ChatService>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        
        
        title: Text("Anonim Gönderiler", style: Get.textTheme.labelLarge!.copyWith(color: Colors.white)),
        centerTitle: true,
        
      ),
      body: Obx(
        ()=>ListView.builder(
          itemBuilder: (context, index) {
            var data = controller.post7[index];
            return data.username.contains("Psikoz")
                ? CardPost(
                  onMessage: ()=> messageController.startConversations(messageController.ilterProfiles(data.uid)),
                  degree: data.degree,
                  onTap: () => Get.to(()=> const SearchProfile(),arguments: data.uid,),
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
