import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/core/constants/CommonTextConstant.dart';
import 'package:psikoz_me/core/constants/LogoResourcesConstants.dart';


class ProfileSet extends StatelessWidget {
  const ProfileSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          "Anonim Profil",
          style: Get.textTheme.bodyText1!
              .copyWith(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(LogoResourcesConstants.ANONIMPICTURE),
            radius: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
                height: 50,
                width: 250,
                child: Center(child: Obx(()=>Text(controller.profileModel.first.anonim==""?"":controller.profileModel.first.anonim,style: TextStyle(color: Colors.black),))),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 1,
                          offset: Offset.infinite),
                    ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.controller.setProfile(CommonTextConstants.ANONIM);
              },
              child: const Text("Yeni bir anonim profil yaratın",),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          )
        ],
      )),
    );
  }
}
