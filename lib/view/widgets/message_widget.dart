import 'package:flutter/material.dart';
import 'package:knockme/model/message_model.dart';

import '../../api/api.dart';
import '../../ults/time_converter.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel data;
  const MessageWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.formId == KnockApis.currentUser.uid
        ? _senderMessage(context)
        : _receiverMessage(context);
  }

  _senderMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          TimeConverter.getTime(data.sentTime),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Color(0xffbebebe)),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0)),
              color: const Color(0xff5fc9f8),
            ),
            child: Text(
              data.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  _receiverMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              color: Color(0xff53d769),
            ),
            child: Text(
              data.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Text(
          '12:03 am',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: const Color(0xffbebebe)),
        )
      ],
    );
  }
}
