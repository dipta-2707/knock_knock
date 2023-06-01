import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/SignUp_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Knock Me!',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.fullNameController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  labelText: 'Full Name'),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.email_outlined), labelText: 'Email'),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                icon: const Icon(Icons.key),
                labelText: 'Password',
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => controller.signUpWithEmailAndPassword(
                        email: controller.emailController.text,
                        password: controller.passwordController.text,
                        displayName: controller.fullNameController.text),
                    child: const Text('Lets Knock!'))),
          ),
          const Spacer(),
          InkWell(
            onTap: () => controller.gotoSignIn(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              color: Colors.amber,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Already a member ?',
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
