import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return snapshot.data!.size > 0
                    ? ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          return UserListTile(
                            onClick: () => controller.gotoChatPage(),
                            userModel: UserModel.fromJson(
                                snapshot.data!.docs[index].data()),
                          );
                        })
                    : const Center(
                        child: Text('No knocks!'),
                      );
            }
          }),
    );
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
}
