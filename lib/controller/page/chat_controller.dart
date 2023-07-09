import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';
import 'package:knockme/model/user_model.dart';

class ChatController extends GetxController {
  late TextEditingController _messageTextController;

  TextEditingController get messageController => _messageTextController;

  @override
  void onInit() {
    super.onInit();
    _messageTextController = TextEditingController();
  }

  /// set message
  Future<void> setMessage(UserModel userModel) async {
    if (_messageTextController.text.isNotEmpty) {
      await KnockApis.setMessages(userModel, _messageTextController.text);
      KnockApis.addToChatList(userModel: userModel);
      // sent push notification if not online
      if (!userModel.isOnline) {
        await KnockApis.sentPushNotification(
            userModel: userModel, message: _messageTextController.text);
      }
      _messageTextController.clear();
    } else {
      return;
    }
  }
}
