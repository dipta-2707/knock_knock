import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';

class ProfileController extends GetxController {
  late TextEditingController nameTextController;
  late TextEditingController bioTextController;

  RxBool _isNameEditActive = false.obs;
  RxBool _isBioEditActive = false.obs;

  bool get isNameEditActive => _isNameEditActive.value;

  bool get isBioEditActive => _isBioEditActive.value;

  void putIsNameEditActive(bool value) => _isNameEditActive.value = value;
  void putIsBioEditActive(bool value) => _isBioEditActive.value = value;

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
}
