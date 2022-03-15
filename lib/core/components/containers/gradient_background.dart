// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  GradientBackground(
      {Key? key, required this.colors})
      : super(key: key);
  
  List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: LinearGradient(colors: colors,)));
  }
}
