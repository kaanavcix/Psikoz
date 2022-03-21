import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/Homeconstants.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';

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
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HomeConstant.DIVIDERCOLOR,width: 0.3))),
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
                    backgroundColor: Colors.black,
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
                          style: HomeConstant.BLUEPOPI.copyWith(fontSize: 12,fontWeight: FontWeight.w700,
                          color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(snap.data()["title"],
                        style: HomeConstant.BLUEPOPI.copyWith(fontSize: 12,fontWeight: FontWeight.normal,
                        color: Colors.grey),

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
