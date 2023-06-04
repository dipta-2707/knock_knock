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
      body: StreamBuilder(
          stream: KnockApis.getAllFriends(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                return snapshot.data!.docs.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          return UserListTile(
                              onClick: () => controller.gotoChatPage(
                                  UserModel.fromJson(
                                      snapshot.data!.docs[index].data())),
                              userModel: UserModel(
                                  image:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
                                  name: 'test name',
                                  bio: 'bio',
                                  createdAt: '651',
                                  id: '6516s5ads6dasd',
                                  lastActive: '65465120',
                                  isOnline: true,
                                  email: 'asdsd',
                                  pushToken: 'asd561s65'));
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
