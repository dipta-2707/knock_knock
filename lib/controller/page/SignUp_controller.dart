import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/config/route_config.dart';
import 'package:knockme/ults/snack_bars.dart';

class SignUpController extends GetxController {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fullNameController;

  get emailController => _emailController;
  get passwordController => _passwordController;
  get fullNameController => _fullNameController;

  @override
  void onInit() {
    super.onInit();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  void gotoSignIn() => Get.toNamed(RouteConfig.singInPageRouteName);
  void gotoHomePage() => Get.offAndToNamed(RouteConfig.homePageRouteName);

  /// sign up  with email and password
  Future<void> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    try {
      await InternetAddress.lookup('google.com');

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (FirebaseAuth.instance.currentUser != null) {
          FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
        }
        gotoHomePage();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          context: Get.context!,
          content: 'sign up error',
          snackBarType: SnackBarType.error);
      if (kDebugMode) {
        print('signUpWithEmailAndPassword : $e');
      }
    }
  }
}
