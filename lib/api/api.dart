import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:knockme/model/message_model.dart';
import 'package:knockme/model/user_model.dart';
import 'package:knockme/ults/snack_bars.dart';

class KnockApis {
  // collection name
  static const String _userCollection = "users";
  static const String _chatCollection = "chats";
  static const String _friendsCollection = "friends";
  static const String _requestCollection = "requests";
  static const String _chatListCollection = "chatList";

  // for firebase Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for Firebase fire store
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for Firebase storage
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // get current user
  static User get currentUser => auth.currentUser!;

  // self info Model
  static late UserModel me;

  // check user exits or not
  static Future<bool> isUserExits() async {
    return (await firestore
            .collection(_userCollection)
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  // get Self Info
  static Future<void> getSelfInfo() async {
    await firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .get()
        .then((value) {
      if (value.exists) {
        // if user found
        me = UserModel.fromJson(value.data()!);
      } else {
        // when user not found . this maybe not happening
      }
    });
  }

  /// update active status
  static Future<void> updateActiveStatus({required bool isOnline}) {
    return firestore.collection(_userCollection).doc(currentUser.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch
    });
  }

  /// send friend request
  static Future<bool> sentFriendRequest({required String email}) async {
    final data = await firestore
        .collection(_userCollection)
        .where('email', isEqualTo: email.trim())
        .get();

    if (data.docs.isNotEmpty && data.docs.first.id != currentUser.uid) {
      /// add for me
      firestore
          .collection(_userCollection)
          .doc(data.docs.first.id)
          .collection(_requestCollection)
          .doc(currentUser.uid)
          .set({});
      return true;
    }
    return false;
  }

  ///  listen friend request
  static Stream<QuerySnapshot<Map<String, dynamic>>> getFriendRequests() {
    return firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_requestCollection)
        .snapshots();
  }

  /// add user to friend list
  static Future<void> addFriend({required String id}) async {
    /// add for me
    firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection('friends')
        .doc(id.trim())
        .set({});
    // also add for friend side
    firestore
        .collection(_userCollection)
        .doc(id.trim())
        .collection('friends')
        .doc(currentUser.uid)
        .set({});

    /// after accepting request we also have to remove the request from database
    rejectFriendRequest(id: id);
  }

  static Future<void> rejectFriendRequest({required String id}) async {
    firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_requestCollection)
        .doc(id.trim())
        .delete();
  }

  /// fetch friends list
  static Stream<QuerySnapshot<Map<String, dynamic>>> getFriends() {
    return firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_friendsCollection)
        .snapshots();
  }

  /// fetch chat List
  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatList() {
    return firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_chatListCollection)
        .snapshots();
  }

  /// add to chat List
  static Future<void> addToChatList({required UserModel userModel}) {
    /// for me
    firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_chatListCollection)
        .doc(userModel.id)
        .set({});

    /// for other
    return firestore
        .collection(_userCollection)
        .doc(userModel.id)
        .collection(_chatListCollection)
        .doc(currentUser.uid)
        .set({});
  }

  /// remove and delete chat
  static Future<void> deleteChat({required String chatId}) async {
    firestore
        .collection(_userCollection)
        .doc(currentUser.uid)
        .collection(_chatListCollection)
        .doc(chatId)
        .delete();
    String conversationId = getConversationId(chatId);

    firestore
        .collection(_chatCollection)
        .doc(conversationId)
        .collection('messages')
        .get()
        .then((value) {
      for (var element in value.docs) {
        firestore
            .collection(_chatCollection)
            .doc(conversationId)
            .collection('messages')
            .doc(element.id)
            .delete();
      }
    });
  }

  /// get listed users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getListedUsers(
      {required List<String> userIds}) {
    return firestore
        .collection(_userCollection)
        .where('id', whereIn: userIds)
        .snapshots();
  }

  /// ----------------------   messages part ----------------- ------------------------
  /// ============================================================
  /// ========================                ======================
  // get message id
  static String getConversationId(String id) {
    if (currentUser.uid.compareTo(id) == -1) {
      return currentUser.uid + id;
    } else {
      return id + currentUser.uid;
    }
  }

  /// get chats
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      UserModel userModel) {
    return firestore
        .collection('chats/${getConversationId(userModel.id)}/messages/')
        .orderBy('sentTime')
        .snapshots();
  }

  ///set messages ---------
  static Future<void> setMessages(UserModel userModel, String msg) async {
    final int time = DateTime.now().millisecondsSinceEpoch;

    final body = MessageModel(
        formId: currentUser.uid,
        toId: userModel.id,
        sentTime: time,
        readTime: 0,
        message: msg,
        type: 'Text');
    await firestore
        .collection('chats/${getConversationId(userModel.id)}/messages/')
        .doc()
        .set(body.toJson());
    //await setUnreadMessageValue(userModel);
  }

  // get last message
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      UserModel userModel) {
    return firestore
        .collection('chats/${getConversationId(userModel.id)}/messages/')
        .orderBy('sentTime', descending: true)
        .limit(1)
        .snapshots();
  }

  /// unread message counter
  // static Future<void> setUnreadMessageValue(UserModel userModel) async {
  //   return firestore
  //       .collection('chats/${getConversationId(userModel.id)}/unread/')
  //       .doc()
  //       .set({
  //     userModel.id: 0,
  //     currentUser.uid: 0,
  //   });
  // }

  // -------------------------------- CREATE  ----------------------------------
  // create a new user
  static Future<void> createUserAccount({required String name}) async {
    final int dateTime = DateTime.now().millisecondsSinceEpoch;
    final user = UserModel(
        image: auth.currentUser!.photoURL ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png',
        name: name,
        bio: auth.currentUser!.displayName ?? "Hey, Knock Me!",
        createdAt: dateTime,
        id: auth.currentUser!.uid,
        lastActive: dateTime,
        isOnline: true,
        email: auth.currentUser!.email ?? '',
        pushToken: '');

    await firestore
        .collection(_userCollection)
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }

  // --------------------------------- UPDATE ----------------------------------
  // update displayName
  static Future<void> updateDisplayName({required String newName}) async {
    if (newName != me.name) {
      try {
        await firestore
            .collection(_userCollection)
            .doc(currentUser.uid)
            .update({"name": newName}).then((value) {
          getSelfInfo();
        });
      } catch (e) {
        KnockSnackBar.showSnackBar(
            context: Get.context!,
            content: 'something went wrong',
            snackBarType: SnackBarType.error);
      }
    }
  }

  /// get avatar images
  static Future<String> getAvatar({required int photoSN}) {
    return firebaseStorage
        .ref()
        .child('avatars/kma$photoSN.png')
        .getDownloadURL();
  }
}
