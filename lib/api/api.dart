import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knockme/model/user_model.dart';

class KnockApis {
  // collection name
  static const String _userCollection = "users";

  // for firebase Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for Firebase fire store
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // check user exits or not
  static Future<bool> isUserExits() async {
    return (await firestore
            .collection(_userCollection)
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  // -------------------------------- CREATE  ----------------------------------
  // create a new user
  static Future<void> createUserAccount({required String name}) async {
    final dateTime = DateTime.now().millisecondsSinceEpoch.toString();
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
}
