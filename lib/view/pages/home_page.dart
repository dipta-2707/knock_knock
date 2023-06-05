import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/controller/page/homePage_controller.dart';
import 'package:knockme/model/user_model.dart';
import 'package:knockme/view/widgets/user_tile.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.message_outlined),
          title: const Text('Knock Me'),
          actions: [_popUpMenu()],
        ),
        floatingActionButton: _addFriendButton(context),
        body: StreamBuilder(
          stream: KnockApis.getFriends(),
          builder: (context, friendSnapshot) {
            switch (friendSnapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                );
              case ConnectionState.done:
              case ConnectionState.active:
                if (friendSnapshot.hasData) {
                  return StreamBuilder(
                    stream: KnockApis.getListedUsers(
                        userIds: friendSnapshot.data?.docs
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
                          if (userSnapshot.hasData) {
                            return ListView.builder(
                              itemCount: userSnapshot.data!.size,
                              itemBuilder: (context, index) {
                                return UserListTile(
                                    userModel: UserModel.fromJson(
                                        userSnapshot.data!.docs[index].data()),
                                    onClick: () {
                                      controller.gotoChatPage(
                                          UserModel.fromJson(userSnapshot
                                              .data!.docs[index]
                                              .data()));
                                    });
                              },
                            );
                          }
                          return const Center(
                            child: Text('no user found'),
                          );
                      }
                    },
                  );
                }
                return const Center(
                  child: Text('No one to Knock.\nAdd your knock friend.'),
                );
            }
          },
        ));
  }

  Widget _popUpMenu() {
    return PopupMenuButton(
      initialValue: -1,
      // Callback that sets the selected popup menu item.
      onSelected: (item) {
        if (item == 0) {
          controller.gotoProfile();
        } else if (item == 1) {
          controller.signOut();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 0,
          child: Text('Profile'),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        ),
      ],
    );
  }

  Widget _addFriendButton(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.blueAccent,
      onPressed: () {
        controller.gotoAddFriendPage();
      },
      child: Icon(
        Icons.person_add_alt_1,
        color: Colors.white,
        size: 22.0,
      ),
    );
  }
}
