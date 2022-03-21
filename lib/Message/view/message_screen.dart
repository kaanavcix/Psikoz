import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Message/controller/messageScreen.dart';
import 'package:psikoz_me/Message/view/message_Detail.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';
import 'package:psikoz_me/core/constants/bottombar_constant.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/message_constant.dart';
import 'package:psikoz_me/core/constants/profile_constans.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthService>();
    var controller2 = Get.find<HomeController>();
    var controller3 = Get.put(MessageSreenController());
    var controller7 = Get.find<ChatService>();

    return Scaffold(
      appBar: AppBar(
        shadowColor: BottomBar_Constant.COLORBLUEKA,
        toolbarHeight: Get.height * 0.12,
        elevation: 2,
        backgroundColor: Search_Constant.COLORBLUEKA,
        flexibleSpace: FlexibleSpaceBar(
            background: Container(
                color: BottomBar_Constant.COLORBLUEKA,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Search_Constant.COLORBLUEKA,
                      backgroundImage: controller2.profileModel.first.image !=
                              ""
                          ? NetworkImage(controller2.profileModel.first.image)
                          : const NetworkImage("https://picsum.photos/200"),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MessageConstants.HOSGELDINIZ,
                          style: ProfileConstants.NUNITOTEXT_STYLE_W700_BLACK,
                        ),
                        Text(controller2.profileModel.first.username,
                            style: Login_Constants.NUNITOTEXT_STYLE_W700
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Typicons.cog,
                          size: 25,
                        ))
                  ],
                ))),
      ),
      body: Obx((() => ListView.builder(
            itemCount: controller7.chat.length,
            itemBuilder: (context, index) {
              return listTile(controller3, index, controller, controller7);
            },
           
          ))),
      floatingActionButton: newMesageFAB(),
    );
  }

  Widget listTile(MessageSreenController controller3, int index,
      AuthService controller, ChatService controller6) {
    return Card(
      child: Dismissible(
        background: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
            color: Colors.red),
        key: ValueKey(controller6.chat[index]),
        onDismissed: (DismissDirection dismissDirection) =>
            controller.deleteChat(controller6.chat[index].docId),
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(controller6.chat[index].profileImage),radius: 23),
          title: Text(controller6.chat[index].name,style: MessageConstants.USERTITLE.copyWith(fontWeight: FontWeight.w500)),
          onTap: () => Get.to(
              CheatDetail(
                  chatModel: controller6.chat[index],
                  userId: controller.auth.currentUser!.uid),
              arguments: controller6.chat[index]),
        ),
      ),
    );
  }

  FloatingActionButton newMesageFAB() {
    return FloatingActionButton(
      onPressed: () {
        Get.bottomSheet(
          bottomSheetPage(),
          isScrollControlled: true,
        );
      },
      backgroundColor: BottomBar_Constant.COLORBLUEKA,
      child: const Icon(FontAwesome.wechat),
    );
  }

  Widget bottomSheetPage() {
    var controller = Get.find<MessageSreenController>();
    var controller2 = Get.find<StatusService>();
    var authcontrol = Get.find<AuthService>();
    return Container(
        height: Get.height * 0.9,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(children: [
          const Icon(Icons.linear_scale_outlined),
          Container(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color.fromARGB(255, 228, 227, 227))
            ], borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                child: TextFormField(
                  controller: controller.messageOpenController,
                  decoration: const InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      )),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      )),
                      labelStyle: TextStyle(fontSize: 12),
                      labelText: "Sohbet Başlatın"),
                  onChanged: (String _) {
                    debugPrint(_);
                  },
                ),
              ),
            ),
          ),
          Expanded(child:  futureBuild(controller2, controller, authcontrol))
        ]));
  }

  FutureBuilder<dynamic> futureBuild(StatusService controller,
      MessageSreenController controller2, AuthService controller3) {
    var chatController = Get.find<ChatService>();
    return FutureBuilder(
      future: chatController
          .filterProfiles(controller2.messageOpenController.value.text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
            children: (snapshot.data as dynamic)
                .map<Widget>(
                  (Profile profile) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            profile.profileImage == " "
                                ? "https://picsum.photos/200"
                                : profile.profileImage),
                        backgroundColor: Colors.black12,
                        foregroundColor: Colors.white,
                      ),
                      title: Text(
                        profile.username,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onTap: () async {
                        Get.back();
                        await chatController.startConversations(profile);
                      }),
                )
                .toList());
      },
    );
  }
}
