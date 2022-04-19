// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';

class EmailInput extends StatelessWidget {
  EmailInput(
      {Key? key, required this.emailController, required this.onFieldSubmitted,required this.validator})
      : super(
          key: key,
        );
  final TextEditingController emailController;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        validator: validator,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            alignLabelWithHint: false,
            label: Text(LoginConstants.MAIL_TEXT,
                style: LoginConstants.NUNITOTEXT_JUST_TEXTSIZE
                    .copyWith(color: Colors.black))),
      ),
    );
  }
}
