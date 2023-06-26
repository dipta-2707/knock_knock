import 'package:get/get.dart';
import 'package:knockme/controller/page/all_friend_page_controller.dart';

class ALlFriendPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllFriendsPageController>(() => AllFriendsPageController());
  }
}
