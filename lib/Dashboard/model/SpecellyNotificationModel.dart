// To parse this JSON data, do
//
//     final specallyNotificationModel = specallyNotificationModelFromJson(jsonString);

import 'dart:convert';

SpecallyNotificationModel specallyNotificationModelFromJson(String str) => SpecallyNotificationModel.fromJson(json.decode(str));

String specallyNotificationModelToJson(SpecallyNotificationModel data) => json.encode(data.toJson());

class SpecallyNotificationModel {
  int? status;
  String? message;
  List<Datum>? data;

  SpecallyNotificationModel({
    this.status,
    this.message,
    this.data,
  });

  factory SpecallyNotificationModel.fromJson(Map<String, dynamic> json) => SpecallyNotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? addBy;
  String? modifyBy;
  String? title;
  String? description;
  String? url;
  String? image;
  String? status;
  String? rediretType;
  DateTime? addDate;
  DateTime? modifyDate;

  Datum({
    this.id,
    this.addBy,
    this.modifyBy,
    this.title,
    this.description,
    this.url,
    this.image,
    this.status,
    this.rediretType,
    this.addDate,
    this.modifyDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    addBy: json["add_by"],
    modifyBy: json["modify_by"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    image: json["image"],
    status: json["status"],
    rediretType: json["rediret_type"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: DateTime.parse(json["modify_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_by": addBy,
    "modify_by": modifyBy,
    "title": title,
    "description": description,
    "url": url,
    "image": image,
    "status": status,
    "rediret_type": rediretType,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate!.toIso8601String(),
  };
}
