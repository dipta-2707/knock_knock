import 'package:get/get.dart';
import 'package:knockme/bindings/homePage_binding.dart';
import 'package:knockme/bindings/signUp_binding.dart';
import 'package:knockme/bindings/singIn_binding.dart';
import 'package:knockme/bindings/splash_binding.dart';
import 'package:knockme/view/pages/home_page.dart';
import 'package:knockme/view/pages/sigin_page.dart';
import 'package:knockme/view/pages/signUp_page.dart';
import 'package:knockme/view/pages/splash_page.dart';

class RouteConfig {
  static const String splashPageRouteName = '/';
  static const String singInPageRouteName = '/singInPage';
  static const String singUpPageRouteName = '/singUpPage';
  static const String homePageRouteName = '/homePage';
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
        page: () => const HomePage(),
        binding: HomePageBinding()),
  ];
}
