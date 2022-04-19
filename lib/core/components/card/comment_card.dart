import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/TextThemeConstants.dart';
import 'package:psikoz_me/core/constants/colorpallette.dart';
import 'package:get/get.dart';
class CommentCard extends StatelessWidget {
  const CommentCard({
    required this.snap,
    Key? key,
  }) : super(key: key);

  final dynamic snap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorPallete.DIVIDERCOLOR,width: 0.3))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorPallete.BLUECOLOR ,
                    backgroundImage:
                        NetworkImage(snap.data()["profilePicture"]),
                    radius: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          snap.data()["username"],
                          style: TextThemeConstants.BLUEPOPI.copyWith(fontSize: 12,fontWeight: FontWeight.w700,
                          color: Get.isDarkMode?Colors.white:Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(snap.data()["title"],
                        style: TextThemeConstants.BLUEPOPI.copyWith(fontSize: 12,fontWeight: FontWeight.normal,
                        color: Get.isDarkMode?Colors.white54:Colors.black54),

                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
