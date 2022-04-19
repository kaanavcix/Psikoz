import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:psikoz_me/core/init/service/AuthService.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';
import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/core/init/service/stroageService.dart';
import 'package:psikoz_me/psikoz.dart';
import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async => await initService());

  runApp(const Psikoz());
}

Future<void> initService() async {
  await Get.putAsync<StroageService>(() async => await StroageService());
  await Get.putAsync<AuthService>(() async => await AuthService());
  await Get.putAsync<StatusService>(() async => await StatusService());
  await Get.putAsync<ChatService>(() async => await ChatService());
}

