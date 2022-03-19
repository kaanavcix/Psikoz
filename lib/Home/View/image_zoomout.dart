import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageZoomOut extends StatelessWidget {
  const ImageZoomOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Center(
      child: Hero(
          tag: "$data",
          child: GestureDetector(
              onTap: (() => Get.back()), child: Image.network(data))),
    );
  }
}
