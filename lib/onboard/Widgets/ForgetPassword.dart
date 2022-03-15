// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';



class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key, required this.onPressed}) : super(key: key);
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(
          textStyle: Login_Constants.NUNITOTEXT_JUST_TEXTSIZE,
          onPrimary: Colors.grey.withOpacity(0.4),
        ),
        onPressed: onPressed,
        child: Text(Login_Constants.FORGET_PASSWORD_TEXT));
  }
}
