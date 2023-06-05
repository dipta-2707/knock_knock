import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/config/route_config.dart';
import 'package:knockme/model/user_model.dart';
import 'package:knockme/view/pages/chat_page.dart';

import '../../ults/snack_bars.dart';

class HomePageController extends GetxController {
  void gotoSignIn() => Get.offAndToNamed(RouteConfig.singInPageRouteName);

  @override
  void onInit() {
    super.onInit();

    // fetching self info after successfully logged in
    KnockApis.getSelfInfo();
  }

  void signOut() {
    //KnockApis.updateActiveStatus();
    FirebaseAuth.instance.signOut();
    gotoSignIn();
  }

  void gotoProfile() {
    Get.toNamed(RouteConfig.profilePageRouteName);
  }

  void gotoChatPage(UserModel userModel) {
    // Get.toNamed(RouteConfig.chatPageRouteName, arguments: userModel);
    // Get.to(() => ChatPage(
    //       userModel: userModel,
    //     ));
  }

  void gotoAddFriendPage() => Get.toNamed(RouteConfig.addFriendPageRouteName);
}
