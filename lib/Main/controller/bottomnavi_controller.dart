import 'package:get/get.dart';
import 'package:psikoz_me/core/init/service/AuthService.dart';

class BottomNavigatiorController extends GetxController {
  var controller = Get.find<AuthService>();
  var selectedItemPosition = 0.obs;
  void selectedItem(int index) {
    selectedItemPosition.value = index;
    update();
  }
}
