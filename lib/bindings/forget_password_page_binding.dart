import 'package:get/get.dart';
import 'package:knockme/controller/page/forget_password_page_controller.dart';

class ForgetPasswordPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordPageController>(
        () => ForgetPasswordPageController());
  }
}
