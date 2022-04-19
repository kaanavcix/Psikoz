import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/ThemeConstant.dart';
import 'package:psikoz_me/core/constants/ColorPallette.dart';
import 'package:psikoz_me/core/constants/LogoResourcesConstants.dart';
import 'package:psikoz_me/onboard/Login/view/customclippath.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PsikozStack extends StatelessWidget {
  const PsikozStack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipPath(
          clipBehavior: Clip.antiAlias,
          clipper: CustomClipPath(),
          child: Container(
            width: Get.width,
            height: Get.height * 0.40,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorPallete.BLUECOLOR,
              ColorPallete.PURPLECOLOR
            ])),
          )),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: SvgPicture.asset(LogoResourcesConstants.LOGO_IMAGE2_SVG,color: ThemeConstant.logoMode,),
          ),
        ),
      ),
      SafeArea(
          child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                ),
              )))
    ]);
  }
}