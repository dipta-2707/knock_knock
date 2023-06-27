import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/config/route_config.dart';
import 'package:knockme/ults/snack_bars.dart';

class SignInController extends GetxController {
  RxBool _isPasswordObsecure = true.obs;

  bool get isPasswordVisible => _isPasswordObsecure.value;

  void setIsPasswordVisible(bool value) => _isPasswordObsecure.value = value;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  get emailController => _emailController;
  get passwordController => _passwordController;

  @override
  void onInit() {
    super.onInit();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void gotoSignUp() => Get.toNamed(RouteConfig.singUpPageRouteName);

  void gotoHomePage() => Get.offAndToNamed(RouteConfig.homePageRouteName);

  /// sign in WIth Email and Password
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await InternetAddress.lookup('google.com');

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await KnockApis.updatePushToken();
        KnockApis.updateActiveStatus(isOnline: true);
        gotoHomePage();
      });
    } catch (e) {
      KnockSnackBar.showSnackBar(
          context: Get.context!,
          content: 'Error',
          snackBarType: SnackBarType.error);
      if (kDebugMode) {
        print('\n signInWithCredential: $e');
      }
    }
  }

  /// sign In with Google
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if ((await KnockApis.isUserExits())) {
          gotoHomePage();
        } else {
          await KnockApis.createUserAccount(
                  name:
                      FirebaseAuth.instance.currentUser!.displayName ?? 'Nobie')
              .then((value) => gotoHomePage());
        }
        _emailController.clear();
        _passwordController.clear();
        _isPasswordObsecure.value = true;
      });
    } catch (e) {
      Get.snackbar(
        "Something went Wrong!",
        "check your internet connection",
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.5),
      );
      if (kDebugMode) {
        print('\n signInWithGoogle: $e');
      }
    }
  }
}
