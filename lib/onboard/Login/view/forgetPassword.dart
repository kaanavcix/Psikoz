import 'package:flutter/material.dart';
import 'package:psikoz_me/core/components/containers/Login_register_background.dart';
import 'package:get/get.dart';

import 'package:psikoz_me/core/init/service/statusService.dart';
import 'package:psikoz_me/onboard/Login/Controller/login_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
    var controller2 = Get.find<StatusService>();

    return Scaffold(resizeToAvoidBottomInset: false,
        body: LinearGradientBackground(

            widget: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
    
         Padding(
           padding: const EdgeInsets.only(bottom:38.0),
           child: Row(children: [InkWell(onTap: ()=> Get.back(),child: Icon(Icons.arrow_back,color: Colors.white),)]),
         ),
        
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextField(
              enableSuggestions: true,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              minLines: 1,
              textAlign: TextAlign.center,
              cursorColor: Colors.transparent,
              decoration: const InputDecoration(
                  enabled: true,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  labelText: "Write Email",
                  labelStyle: TextStyle(fontSize: 12, color: Colors.black)),
              controller: controller.forgetPassword,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
             GetUtils.isEmail( controller.forgetPassword.text) ?  controller2
                  .resetPasswordSendEmailAdress(controller.forgetPassword.text)!
                  .then((value) => Get.back()):Get.snackbar("Error", "E-mailinizi kontrol edin",backgroundColor: Colors.red);
            },
            child: Container(
              width: 200,
              height: 50 ,
              child: Center(child: Text("Gönder")),

              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),),
            )
      ],
    )));
  }
}
