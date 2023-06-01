import 'package:get/get.dart';
import 'package:knockme/controller/page/signIn_controller.dart';
import 'package:knockme/controller/page/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashPageController>(SplashPageController());
  }
}
