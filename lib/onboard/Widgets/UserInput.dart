// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:psikoz_me/core/constants/register_constant.dart';

class UserInput extends StatelessWidget {
  UserInput({
    Key? key,required this.userController
  }) : super(key: key,);
TextEditingController userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        
        controller: userController,
        decoration: InputDecoration(
          
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            alignLabelWithHint: false,
            label: Text(Register_Constants.USERNAME_TEXT,
                style: Login_Constants.NUNITOTEXT_JUST_TEXTSIZE
                    .copyWith(color: Colors.black))),
      ),
    );
  }
}
