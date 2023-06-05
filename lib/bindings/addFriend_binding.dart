import 'package:get/get.dart';
import 'package:knockme/controller/page/add_friend_controller.dart';

class AddFriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFriendController>(() => AddFriendController());
  }
}
