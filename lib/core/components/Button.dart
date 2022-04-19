import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';

class PsikozButton extends StatelessWidget {
  PsikozButton({this.colors,Key? key, this.text, this.style, this.onTap,}) : super(key: key);
  var text;
  dynamic style;
  dynamic onTap;
  dynamic colors;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_circle_right_outlined, color: Colors.white)
          ],
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colors),
      ),
    );
  }
}
