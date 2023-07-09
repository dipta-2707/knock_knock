import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/page/forget_password_page_controller.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordPageController> {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Dont worry! We got you. Just give your account email address.We will sent a email to recover your password.',
                style: Get.textTheme.labelMedium,
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email_outlined), labelText: 'Email'),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.sentResetMail();
                      },
                      child: const Text('sent')))
            ],
          ),
        ),
      ),
    );
  }
}
