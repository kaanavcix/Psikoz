// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.emailController})
      : super(
          key: key,
        );
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            alignLabelWithHint: false,
            label: Text(Login_Constants.MAIL_TEXT,
                style: Login_Constants.NUNITOTEXT_JUST_TEXTSIZE
                    .copyWith(color: Colors.black))),
      ),
    );
  }
}
