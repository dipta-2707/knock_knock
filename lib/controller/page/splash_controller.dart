import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:knockme/config/route_config.dart';

import '../../api/api.dart';

class SplashPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 700)).then((value) {
      if (FirebaseAuth.instance.currentUser != null) {
        KnockApis.updateActiveStatus(isOnline: true);
        Get.offAndToNamed(RouteConfig.homePageRouteName);
      } else {
        Get.offAndToNamed(RouteConfig.singInPageRouteName);
      }
    });
  }
}
