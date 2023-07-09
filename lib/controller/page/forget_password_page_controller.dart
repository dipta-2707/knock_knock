import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/config/route_config.dart';

class ForgetPasswordPageController extends GetxController {
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  void sentResetMail() {
    if (emailController.text.isNotEmpty) {
      KnockApis.auth.sendPasswordResetEmail(email: emailController.text);
      emailController.clear();

      Get.defaultDialog(
        title: 'Reset email sent',
        content: Text('Please check your email inbox for the reset link'),
        onConfirm: () => Get.toNamed(RouteConfig.singInPageRouteName),
      );
    }
  }
}
