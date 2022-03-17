import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psikoz_me/core/constants/routes_constant.dart';
import 'package:psikoz_me/core/init/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Psikoz());

}




class Psikoz extends StatelessWidget {
  const Psikoz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      
      title: 'Psikoz App',
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      
      initialRoute: Routes_Constant.LOGIN,
    );
  }
}
