import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knockme/api/api.dart';

class ProfileController extends GetxController {
  late TextEditingController nameTextController;
  late TextEditingController bioTextController;

  RxInt _selectedAvatarIndex = 0.obs;

  int get selectedAvatarIndex => _selectedAvatarIndex.value;

  void putSelectedAvatarIndex(int value) => _selectedAvatarIndex.value = value;

  RxBool _isNameEditActive = false.obs;
  RxBool _isBioEditActive = false.obs;

  RxBool _isAvatarLoading = true.obs;
  bool get isAvatarLoading => _isAvatarLoading.value;

  bool get isNameEditActive => _isNameEditActive.value;

  bool get isBioEditActive => _isBioEditActive.value;

  void putIsNameEditActive(bool value) => _isNameEditActive.value = value;
  void putIsBioEditActive(bool value) => _isBioEditActive.value = value;

  RxList<String> avatarUrls = <String>[].obs;

  Rx<String> currentPhoto = ''.obs;

  @override
  void onInit() {
    super.onInit();

    nameTextController = TextEditingController();
    bioTextController = TextEditingController();

    nameTextController.text = KnockApis.me.name;
    bioTextController.text = KnockApis.me.bio;
    loadCurrentPhoto();
  }

  void updateDisplayName({required String newName}) {
    KnockApis.updateProfile(newName: newName);
    nameTextController.text = newName;
    update();
  }

  void updateBioName() {
    KnockApis.updateProfile(newBio: bioTextController.text);
    update();
  }

  void updateAvatar() {
    KnockApis.updateProfile(newAvatar: avatarUrls[selectedAvatarIndex]);
    loadCurrentPhoto();
  }

  void loadTheAvatars() {
    if (avatarUrls.isEmpty) {
      _isAvatarLoading.value = true;
      for (var i = 1; i <= 22; i++) {
        KnockApis.getAvatar(photoSN: i).then((value) {
          avatarUrls.add(value);
        });
      }
      _isAvatarLoading.value = false;
    }
  }

  void loadCurrentPhoto() {
    if (avatarUrls.isEmpty) {
      currentPhoto.value = KnockApis.me.image;
    } else {
      currentPhoto.value = avatarUrls[selectedAvatarIndex];
    }
  }
}
