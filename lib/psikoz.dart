import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:psikoz_me/core/constants/RouteConstants.dart';
import 'package:psikoz_me/core/init/routes/routes.dart';

import 'package:psikoz_me/core/theme/dark_theme.dart';
import 'package:psikoz_me/core/theme/light_theme.dart';


class Psikoz extends StatelessWidget {
  const Psikoz({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Psikoz',
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      initialRoute: Routes_Constant.LOGIN,

    );
  }
}
