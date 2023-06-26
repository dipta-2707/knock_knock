import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knockme/controller/page/chat_controller.dart';
import 'package:knockme/model/message_model.dart';
import 'package:knockme/model/user_model.dart';

import '../../api/api.dart';
import '../../ults/time_converter.dart';
import '../widgets/message_widget.dart';

class ChatPage extends GetView<ChatController> {
  final UserModel userModel;
  const ChatPage({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.network(
                userModel.image,
                width: 35,
                height: 35,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  userModel.isOnline
                      ? 'Active Now'
                      : 'Last seen at ${TimeConverter.getTime(userModel.lastActive)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10.0, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: KnockApis.getAllMessages(userModel),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: false,
                          reverse: false,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return MessageWidget(
                              data: MessageModel.fromJson(
                                  snapshot.data!.docs[index].data()),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('lets knock!'),
                      );
                    }
                }
              },
            )),
            _bottomMessagePart()
          ],
        ),
      ),
    );
  }

  _bottomMessagePart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: controller.messageController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 4,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.blue,
                    )),
                border: InputBorder.none,
                hintText: 'Start typing...'),
          )),
          IconButton(
            onPressed: () {
              controller.setMessage(userModel);
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          )
        ],
      ),
    );
  }
}
