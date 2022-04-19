// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/Search/controller/searchController.dart';
import 'package:psikoz_me/Search/view/SearchDetail.dart';
import 'package:psikoz_me/Search/view/searchProfile.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
     var controller2 = Get.put(SearchController());
  var controller = Get.find<StatusService>();
    return Scaffold(
        appBar: appBarSearch(controller2),
        body: controller2.searchControl.text.length > 1
            ? futureBuild(controller, controller2)
            : gridSearch(controller2));
  }

  PreferredSize appBarSearch(SearchController controller2) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: AppBar(
        backgroundColor: ColorPallete.BLUECOLOR,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: ColorPallete.LINEARGRADIENT_COLOR))),
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Get.isDarkMode?ColorPallete.SEARCHCOLOR:Colors.white54),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              style: TextStyle(color: ThemeConstant.textField),
              cursorColor: ColorPallete.BLUECOLOR,
              controller: controller2.searchControl,
              decoration: InputDecoration(border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              
                  labelText: "Arama",
                  labelStyle: Get.theme.textTheme.bodyMedium!.copyWith(color: ThemeConstant.textField)),
              onChanged: (String _) {
                debugPrint(_);

                setState(() {
                  
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> futureBuild(
      StatusService controller, SearchController controller2) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("Person")
          .where("username",
              isGreaterThanOrEqualTo: controller2.searchControl.text)
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.to(const SearchProfile(),
                    arguments: (snapshot.data! as dynamic).docs[index]['uid']),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['Image'],
                    ),
                    radius: 16,
                  ),
                  title: Text(
                    (snapshot.data! as dynamic).docs[index]['username'],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget gridSearch(SearchController controller2) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: controller2.physcologyObject.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => Get.to(const SearchDetail(), arguments: index),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 0.3, color: ColorPallete.BLUECOLOR)),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SvgPicture.asset(
                          controller2.physcologyObject[index].imageAsset,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        top: Get.height * 0.14,
                        left: Get.width * 0.02,
                        child: Text(controller2.physcologyObject[index].name,
                            style: LoginConstants.NUNITOTEXT_STYLE_BOLD
                                .copyWith(
                                    fontSize: 9,
                                    color: Colors.white,
                                    backgroundColor: Colors.black54)))
                  ],
                )),
          ),
        );
      },
    );
  }
}
