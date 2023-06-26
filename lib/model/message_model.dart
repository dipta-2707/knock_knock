import 'dart:convert';

class MessageModel {
  final String formId;
  final String toId;
  final int sentTime;
  final int readTime;
  final String message;
  final String type;

  MessageModel({
    required this.formId,
    required this.toId,
    required this.sentTime,
    required this.readTime,
    required this.message,
    required this.type,
  });

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        formId: json["formId"],
        toId: json["toId"],
        sentTime: json["sentTime"],
        readTime: json["readTime"],
        message: json["message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "formId": formId,
        "toId": toId,
        "sentTime": sentTime,
        "readTime": readTime,
        "message": message,
        "type": type,
      };
}
