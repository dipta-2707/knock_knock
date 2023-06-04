import 'package:get/get.dart';
import 'package:knockme/bindings/chat_binding.dart';
import 'package:knockme/bindings/homePage_binding.dart';
import 'package:knockme/bindings/profile_binding.dart';
import 'package:knockme/bindings/signUp_binding.dart';
import 'package:knockme/bindings/singIn_binding.dart';
import 'package:knockme/bindings/splash_binding.dart';
import 'package:knockme/view/pages/chat_page.dart';
import 'package:knockme/view/pages/home_page.dart';
import 'package:knockme/view/pages/sigin_page.dart';
import 'package:knockme/view/pages/signUp_page.dart';
import 'package:knockme/view/pages/splash_page.dart';

import '../model/user_model.dart';
import '../view/pages/profile_page.dart';

class RouteConfig {
  static const String splashPageRouteName = '/';
  static const String singInPageRouteName = '/singInPage';
  static const String singUpPageRouteName = '/singUpPage';
  static const String homePageRouteName = '/homePage';
  static const String profilePageRouteName = '/profilePage';
  static const String chatPageRouteName = '/chatPage';
  static final pages = [
    GetPage(
        name: splashPageRouteName,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: singInPageRouteName,
        page: () => const SignInPage(),
        binding: SignInBinding()),
    GetPage(
        name: singUpPageRouteName,
        page: () => const SignUpPage(),
        binding: SignUpBinding()),
    GetPage(
        name: homePageRouteName,
        page: () => HomePage(),
        binding: HomePageBinding()),
    GetPage(
        name: profilePageRouteName,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: chatPageRouteName,
        page: () => ChatPage(
              userModel: Get.arguments,
            ),
        binding: ChatBinding(),
        transition: Transition.cupertino),
  ];
}
