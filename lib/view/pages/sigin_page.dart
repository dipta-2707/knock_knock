import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/signIn_controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Hero(
            tag: 'knock_tag',
            child: Text(
              'Knock Me!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.email_outlined), labelText: 'Email'),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              () => TextFormField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordVisible,
                decoration: InputDecoration(
                    icon: const Icon(Icons.key),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.setIsPasswordVisible(
                              !controller.isPasswordVisible);
                        },
                        icon: Icon(controller.isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined))),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => controller.signInWithEmailAndPassword(
                        email: controller.emailController.text,
                        password: controller.passwordController.text),
                    child: const Text('Knock Knock!'))),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  height: 1.0,
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Text(
                'others',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(child: Divider())
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          IconButton(
              onPressed: () {
                controller.signInWithGoogle();
              },
              icon: Image.network(
                'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                width: 42.0,
                height: 42.0,
              )),
          const Spacer(),
          InkWell(
            onTap: () => controller.gotoSignUp(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              color: Theme.of(context).colorScheme.secondary,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Join Now!',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
