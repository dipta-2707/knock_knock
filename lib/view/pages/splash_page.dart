import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
            tag: 'knock_tag',
            child: Text(
              'Knock Me!',
              style: Theme.of(context).textTheme.headlineLarge,
            )),
      ),
    );
  }
}
