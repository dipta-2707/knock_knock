import 'package:flutter/material.dart';

class WidgetUserTile extends StatelessWidget {
  const WidgetUserTile({Key? key}) : super(key: key);

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
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
            width: 45,
            height: 45,
          ),
        ),
        title: Text('User Name'),
        subtitle: Text('hey. how are you?'),
        trailing: Icon(
          Icons.circle,
          color: Colors.green,
          size: 10.0,
        ),
      ),
    );
  }
}
