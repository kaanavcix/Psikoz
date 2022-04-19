import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Profile/settings/anonim.dart';
import 'package:psikoz_me/Profile/settings/profileSet.dart';
import 'package:psikoz_me/Profile/view/model/settingsNames.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';

import 'package:psikoz_me/core/constants/profile_constans.dart';

import 'package:psikoz_me/core/init/service/AuthService.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthService>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(ProfileConstants.SETTINGS_TEXT,
            style:Get.theme.textTheme.subtitle1),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: const Text("Anonim Gönderiler"),
                  onTap: () => Get.to(()=>AnonimPage()),
                ),
              ), Card(
                child: ListTile(
                  title: const Text("Anonim Profil"),
                  onTap: () => Get.to(()=>ProfileSet()),
                ),
              ),
         
            ],
          )),
          button("Çıkış Yap", () {
            controller.signOut();
          }),
          const SizedBox(
            height: 25,
          ),
          const Text("Bexbow Inc.")
        ],
      ),
    );
  }

  Widget button(String text, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.9,
        height: 50,
        child: Center(
            child: Center(
          child: Text(
            text,
            style: ProfileConstants.BUTTONSTYLE,
          ),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: ColorPallete.LINEARGRADIENT_COLOR,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            //color: const Color.fromRGBO(47, 187, 240, 1.0),
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 0.5, spreadRadius: 0.4)
            ]),
      ),
    );
  }

  IconButton exit(AuthService controller) {
    return IconButton(
        onPressed: () {
          controller.signOut();
        },
        icon: const Icon(Icons.abc_outlined));
  }
}
