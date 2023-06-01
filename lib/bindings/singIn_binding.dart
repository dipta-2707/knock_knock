import 'package:get/get.dart';
import 'package:knockme/controller/page/signIn_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
