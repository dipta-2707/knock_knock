import 'package:get/get.dart';
import 'package:knockme/controller/page/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
