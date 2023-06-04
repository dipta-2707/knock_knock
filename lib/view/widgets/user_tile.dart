import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/ults/time_converter.dart';

import '../../model/user_model.dart';

class UserListTile extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onClick;
  const UserListTile({Key? key, required this.userModel, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: onClick,
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            userModel.image,
            width: 45,
            height: 45,
          ),
        ),
        title: Text(userModel.name),
        subtitle: StreamBuilder(
            stream: KnockApis.getLastMessage(userModel),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const SizedBox();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return Text(
                        snapshot.data!.docs[0].data()['message'],
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black54),
                      );
                    }
                    return const SizedBox();
                  }
                  return const SizedBox();
              }
            }),
        trailing: userModel.isOnline
            ? const Icon(
                Icons.circle,
                color: Colors.green,
                size: 10.0,
              )
            : Text(TimeConverter.getTime(userModel.lastActive)),
      ),
    );
  }
}
