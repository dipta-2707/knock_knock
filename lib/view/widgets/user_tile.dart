import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class UserListTile extends StatelessWidget {
  final UserModel userModel;
  const UserListTile({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print('long press');
      },
      onTap: () {},
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            userModel.image,
            width: 45,
            height: 45,
          ),
        ),
        title: Text(userModel.name),
        subtitle: Text('hey. how are you?'),
        trailing: userModel.isOnline
            ? const Icon(
                Icons.circle,
                color: Colors.green,
                size: 10.0,
              )
            : null,
      ),
    );
  }
}
