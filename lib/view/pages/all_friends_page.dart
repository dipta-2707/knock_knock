import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/all_friend_page_controller.dart';

import '../../api/api.dart';
import '../../model/user_model.dart';
import '../widgets/friend_tile.dart';

class AllFriendPage extends GetView<AllFriendsPageController> {
  const AllFriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Friends'),
      ),
      body: StreamBuilder(
          stream: KnockApis.getFriends(),
          builder: (context, requestSnapshot) {
            switch (requestSnapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const SizedBox();
              case ConnectionState.done:
              case ConnectionState.active:
                if (requestSnapshot.data!.size > 0) {
                  return StreamBuilder(
                    stream: KnockApis.getListedUsers(
                        userIds: requestSnapshot.data?.docs
                                .map((e) => e.id)
                                .toList() ??
                            []),
                    builder: (context, userSnapshot) {
                      switch (userSnapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          );
                        case ConnectionState.done:
                        case ConnectionState.active:
                          if (userSnapshot.data!.size > 0) {
                            return ListView.builder(
                              itemCount: userSnapshot.data!.size,
                              itemBuilder: (context, index) {
                                return FriendTile(
                                    userModel: UserModel.fromJson(
                                        userSnapshot.data!.docs[index].data()));
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                      }
                    },
                  );
                }
                return const SizedBox();
            }
          }),
    );
  }
}
