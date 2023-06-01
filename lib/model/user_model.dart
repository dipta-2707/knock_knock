import 'dart:convert';

class UserModel {
  final String image;
  final String name;
  final String bio;
  final String createdAt;
  final String id;
  final String lastActive;
  final bool isOnline;
  final String email;
  final String pushToken;

  UserModel({
    required this.image,
    required this.name,
    required this.bio,
    required this.createdAt,
    required this.id,
    required this.lastActive,
    required this.isOnline,
    required this.email,
    required this.pushToken,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        image: json["image"],
        name: json["name"],
        bio: json["bio"],
        createdAt: json["created_at"],
        id: json["id"],
        lastActive: json["last_active"],
        isOnline: json["is_online"],
        email: json["email"],
        pushToken: json["push_token"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "bio": bio,
        "created_at": createdAt,
        "id": id,
        "last_active": lastActive,
        "is_online": isOnline,
        "email": email,
        "push_token": pushToken,
      };
}
