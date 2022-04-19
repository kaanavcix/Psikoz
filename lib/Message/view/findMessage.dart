import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Message/controller/messageScreen.dart';
import 'package:psikoz_me/Message/view/model/profile.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';

class SearchMessage extends StatefulWidget {
  const SearchMessage({Key? key}) : super(key: key);

  @override
  State<SearchMessage> createState() => _SearchMessageState();
}

class _SearchMessageState extends State<SearchMessage> {
  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatService());
    var controller2 = Get.put(MessageSreenController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Get.size * 0.13,
        child: AppBar(
            backgroundColor: ColorPallete.BLUECOLOR,
            automaticallyImplyLeading: true,
            elevation: 0,
            leadingWidth: 20,
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Get.isDarkMode?Colors.white54:Colors.black54),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        child: TextFormField(
                          controller: controller2.messageOpenController,
                          decoration:  InputDecoration(
                              disabledBorder: InputBorder.none
                              ,
                              enabledBorder:InputBorder.none
                              ,
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              
                              labelStyle: Get.textTheme.headline1,
                              labelText: "Sohbet Başlatın"),
                          onChanged: (String _) {
                            debugPrint(_);
                            setState(() {});
                          },
                        ),
                      ),
                    )),
              ),
            )),
      ),
      body: FutureBuilder(
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
                          await chatController.startConversations(profile);
                        }),
                  )
                  .toList());
        },
      ),
    );
  }
}
