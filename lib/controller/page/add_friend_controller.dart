import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../ults/snack_bars.dart';

class AddFriendController extends GetxController {
  late TextEditingController _emailController;
  TextEditingController get emailController => _emailController;
  @override
  void onInit() {
    super.onInit();
    _emailController = TextEditingController();
  }

  // fetching user fiends list only
  void addMyFriends() async {
    if (emailController.text.isNotEmpty &&
        await (KnockApis.sentFriendRequest(email: emailController.text))) {
      //  email found and request sent
      KnockSnackBar.showSnackBar(
          context: Get.context!,
          content: 'Added to your Knock list.',
          snackBarType: SnackBarType.success);
    } else {
      // email not found or user not exits
      KnockSnackBar.showSnackBar(
          context: Get.context!,
          content:
              'no user found with this email. invite your friend to knockMe',
          snackBarType: SnackBarType.error);
    }
    emailController.clear();
  }

  void acceptRequest({required String id}) {
    KnockApis.addFriend(id: id);
  }

  void rejectRequest({required String id}) {
    KnockApis.rejectFriendRequest(id: id);
  }
}
