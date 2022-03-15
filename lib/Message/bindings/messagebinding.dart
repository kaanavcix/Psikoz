import 'package:get/get.dart';
import 'package:psikoz_me/Message/controller/messageController.dart';
import 'package:psikoz_me/Message/controller/messageScreen.dart';
import 'package:psikoz_me/core/init/service/chatService.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MessageController());
    Get.put(MessageSreenController());
    Get.put(ChatController());
  }
}
