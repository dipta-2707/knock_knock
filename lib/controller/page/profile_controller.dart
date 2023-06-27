import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';

class ProfileController extends GetxController {
  late TextEditingController nameTextController;
  late TextEditingController bioTextController;

  RxBool _isNameEditActive = false.obs;
  RxBool _isBioEditActive = false.obs;

  RxBool _isAvatarLoading = true.obs;
  bool get isAvatarLoading => _isAvatarLoading.value;

  bool get isNameEditActive => _isNameEditActive.value;

  bool get isBioEditActive => _isBioEditActive.value;

  void putIsNameEditActive(bool value) => _isNameEditActive.value = value;
  void putIsBioEditActive(bool value) => _isBioEditActive.value = value;

  List<String> avatarUrls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    nameTextController = TextEditingController();
    bioTextController = TextEditingController();

    nameTextController.text = KnockApis.me.name;
    bioTextController.text = KnockApis.me.bio;
  }

  void updateDisplayName({required String newName}) {
    KnockApis.updateDisplayName(newName: newName);
    nameTextController.text = newName;
    update();
  }

  void loadTheAvatars() {
    if (true) {
      _isAvatarLoading.value = true;
      for (var i = 1; i <= 20; i++) {
        KnockApis.getAvatar(photoSN: i).then((value) {
          avatarUrls.add(value);
          print('index : $i value: %+$value');
        });
      }
      _isAvatarLoading.value = false;
    }
  }
}
