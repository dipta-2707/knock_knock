import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';

import '../../controller/page/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  KnockApis.me.image,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 14,
                      ),
                      alignment: Alignment.center,
                      color: Colors.white,
                      tooltip: 'upload your profile picture',
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  controller.putIsNameEditActive(true);
                },
                child: !controller.isNameEditActive
                    ? Flexible(
                        child: Text(
                          controller.nameTextController.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      )
                    : TextFormField(
                        controller: controller.nameTextController,
                        onFieldSubmitted: (value) {
                          controller.updateDisplayName(
                              newName: controller.nameTextController.text);
                          controller.putIsNameEditActive(false);
                        },
                        decoration:
                            const InputDecoration(labelText: 'update name'),
                      ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Text('Bio'),
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    controller.putIsBioEditActive(true);
                  },
                  child: !controller.isBioEditActive
                      ? Text(
                          controller.bioTextController.text,
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : TextFormField(
                          controller: controller.bioTextController,
                          onFieldSubmitted: (value) {
                            controller.putIsBioEditActive(false);
                          },
                          decoration:
                              const InputDecoration(labelText: 'update bio'),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
