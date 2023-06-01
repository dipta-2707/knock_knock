import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/config/route_config.dart';

class HomePageController extends GetxController {
  void gotoSignIn() => Get.offAndToNamed(RouteConfig.singInPageRouteName);

  @override
  void onInit() {
    super.onInit();
    // fetching self info after successfully logged in
    KnockApis.getSelfInfo();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    gotoSignIn();
  }

  void gotoProfile() {
    Get.toNamed(RouteConfig.profilePageRouteName);
  }
}
