// To parse this JSON data, do
//
//     final liveChatModel = liveChatModelFromJson(jsonString);

import 'dart:convert';

LiveChatModel liveChatModelFromJson(String str) => LiveChatModel.fromJson(json.decode(str));

String liveChatModelToJson(LiveChatModel data) => json.encode(data.toJson());

class LiveChatModel {
  int? status;
  String? message;
  List<dynamic>? data;

  LiveChatModel({
    this.status,
    this.message,
    this.data,
  });

  factory LiveChatModel.fromJson(Map<String, dynamic> json) => LiveChatModel(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["Data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x)),
  };
}
