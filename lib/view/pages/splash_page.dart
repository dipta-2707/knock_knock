import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/splash_controller.dart';
import 'package:knockme/model/knock_me_icon_icons.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: 'knock_me',
          child: Icon(
            KnockMeIcon.mainLogo,
            size: 48.0,
          ),
        ),
      ),
    );
  }
}
