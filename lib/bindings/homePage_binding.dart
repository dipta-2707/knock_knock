import 'package:get/get.dart';
import 'package:knockme/controller/page/homePage_controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
