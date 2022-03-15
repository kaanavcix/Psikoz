// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:psikoz_me/core/constants/search_constants.dart';

class LinearGradientBackground extends StatelessWidget {
  const LinearGradientBackground({
    Key? key,
    required this.widget,
  }) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: Search_Constant.LINEARGRADIENT_COLOR,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)
                ));
  }
}
