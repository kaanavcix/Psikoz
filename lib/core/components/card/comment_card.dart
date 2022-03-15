import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';

class CommentCard extends StatelessWidget {
  
  const CommentCard({ required this.snap,
    Key? key,
  }) : super(key: key);

  final dynamic snap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Color.fromARGB(255, 230, 228, 228),blurRadius: 1,spreadRadius: 1)]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start
              ,crossAxisAlignment: CrossAxisAlignment.center
              ,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(snap.data()["profilePicture"]),
                      radius: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(snap.data()["username"],style: Login_Constants.NUNITOTEXT_STYLE_W700.copyWith(color: Colors.black,fontSize: 18),),
                    ),Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(snap.data()["title"]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                
              ],
            ),
          )),
    );
  }
}
