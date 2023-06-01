import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://avatars.githubusercontent.com/u/58099256?v=4',
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
                  'Name here',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Active Now',
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
      body: Column(
        children: [_bottomMessagePart()],
      ),
    );
  }

  _bottomMessagePart() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.deepPurple,
                    )),
                border: InputBorder.none,
                hintText: 'Start typing...'),
          )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
