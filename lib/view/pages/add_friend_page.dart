import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/add_friend_controller.dart';
import 'package:knockme/model/user_model.dart';

import '../../api/api.dart';

class AddFriendPage extends GetView<AddFriendController> {
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Knock'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'person email address'),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                      onPressed: () {
                        controller.addMyFriends();
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Friend requests ',
              style: TextStyle(color: Color(0x88000000)),
            ),
            const SizedBox(
              height: 10.0,
            ),
            StreamBuilder(
                stream: KnockApis.getFriendRequests(),
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
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: userSnapshot.data!.size,
                                      itemBuilder: (context, index) {
                                        return _requestsTile(UserModel.fromJson(
                                            userSnapshot.data!.docs[index]
                                                .data()));
                                      },
                                    ),
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
          ],
        ),
      ),
    );
  }

  Widget _requestsTile(UserModel userModel) {
    return ListTile(
      leading: Image.network(
        userModel.image,
        fit: BoxFit.cover,
        width: 40.0,
        height: 40.0,
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(userModel.name),
      subtitle: Text(userModel.bio),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              controller.rejectRequest(id: userModel.id);
            },
            color: Colors.red,
            icon: const Icon(
              Icons.close,
              size: 18,
            ),
          ),
          const SizedBox(
            width: 4.0,
          ),
          IconButton(
            onPressed: () {
              controller.acceptRequest(id: userModel.id);
            },
            color: Colors.green,
            icon: const Icon(
              Icons.done,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
