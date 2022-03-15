// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psikoz_me/Home/Controller/homeController.dart';
import 'package:psikoz_me/Search/view/model/searchMode.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<Variable>(Variable());
    var controller2 = Get.put(HomeController());
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: controller.PHYSCOLOGYOBJECTNAME.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            controller2.selectedTag.value =
                controller.PHYSCOLOGYOBJECTNAME[index];
            controller2.data = index;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(74, 105, 255, 0.7),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white, blurRadius: 1, spreadRadius: 1)
                  ]),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.PHYSCOLOGYOBJECTNAME[index],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
