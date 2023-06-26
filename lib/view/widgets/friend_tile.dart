import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/all_friend_page_controller.dart';

import '../../api/api.dart';
import '../../config/route_config.dart';
import '../../model/user_model.dart';

class FriendTile extends GetView<AllFriendsPageController> {
  final UserModel userModel;
  const FriendTile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        // Get.defaultDialog(
        //   title: 'Delete Chat',
        //   content: const Text(
        //       'Are you sure? This action can not be undo. All message will be deleted from both side.'),
        //   onConfirm: () {
        //     KnockApis.deleteChat(chatId: userModel.id);
        //     //print(userModel.id);
        //     Get.back();
        //   },
        //   onCancel: () {
        //     Get.back();
        //   },
        // );
      },
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            userModel.image,
            width: 45,
            height: 45,
          ),
        ),
        title: Text(userModel.name),
        subtitle: Text(userModel.bio),
        trailing: IconButton(
            onPressed: () {
              Get.toNamed(RouteConfig.chatPageRouteName, arguments: userModel);
            },
            icon: const Icon(Icons.message_outlined)),
      ),
    );
  }
}
