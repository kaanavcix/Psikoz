// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/login_constant.dart';
import 'package:flutter_svg/svg.dart';
class TrendContainer extends StatelessWidget {
   const TrendContainer({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(183, 255, 193, 7)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              SvgPicture.asset(LoginConstants.LOGO_IMAGE2_SVG,
                  color: const Color.fromARGB(255, 97, 12, 12), height: 30),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Trend",
                style: LoginConstants.NUNITOTEXT_STYLE.copyWith(fontSize: 14),
              )
            ],
          ),
        ));
  }
}

