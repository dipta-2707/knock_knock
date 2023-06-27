import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';

import '../../controller/page/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-----------update');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Obx(
                  () => CachedNetworkImage(
                    imageUrl: controller.currentPhoto(),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),

                /// edit button ==============
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: IconButton(
                      onPressed: () {
                        controller.loadTheAvatars();

                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                              child: Obx(
                                () => !controller.isAvatarLoading
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text('Choose your avatar'),
                                          Expanded(
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                width: 8.0,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  controller.avatarUrls.length,
                                              itemBuilder: (context, index) {
                                                return buildAvatar(index);
                                              },
                                            ),
                                          ),
                                          ElevatedButton(
                                              child: const Text('save'),
                                              onPressed: () {
                                                controller.updateAvatar();
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.0,
                                        ),
                                      ),
                              ),
                            );
                          },
                        );
                      },
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
              () => !controller.isNameEditActive
                  ? Flexible(
                      child: InkWell(
                        onTap: () {
                          controller.putIsNameEditActive(true);
                        },
                        child: Text(
                          controller.nameTextController.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
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
                            controller.updateBioName();
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

  Widget buildAvatar(int index) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        controller.putSelectedAvatarIndex(index);
      },
      child: Obx(
        () => Container(
          width: 90.0,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color: controller.selectedAvatarIndex == index
                      ? Colors.green
                      : Colors.transparent),
              shape: BoxShape.circle),
          child: CachedNetworkImage(
            imageUrl: controller.avatarUrls[index],
            width: 90.0,
            placeholder: (context, url) => Container(
              width: 90.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEBEBF4),
                      Color(0xFFF4F4F4),
                      Color(0xFFEBEBF4),
                    ],
                    stops: [
                      0.1,
                      0.3,
                      0.4,
                    ],
                    begin: Alignment(-1.0, -0.3),
                    end: Alignment(1.0, 0.3),
                    tileMode: TileMode.clamp,
                  )),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
