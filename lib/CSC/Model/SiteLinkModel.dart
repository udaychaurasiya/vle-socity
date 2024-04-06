// To parse this JSON data, do
//
//     final siteLinkModel = siteLinkModelFromJson(jsonString);

import 'dart:convert';

SiteLinkModel siteLinkModelFromJson(String str) => SiteLinkModel.fromJson(json.decode(str));

String siteLinkModelToJson(SiteLinkModel data) => json.encode(data.toJson());

class SiteLinkModel {
  int? status;
  String? message;
  List<Datum>? data;

  SiteLinkModel({
    this.status,
    this.message,
    this.data,
  });

  factory SiteLinkModel.fromJson(Map<String, dynamic> json) => SiteLinkModel(
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
  String? title;
  String? url;
  String? status;
  String? modifyDate;

  Datum({
    this.id,
    this.title,
    this.url,
    this.status,
    this.modifyDate,
  });
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    status: json["status"],
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "status": status,
    "modify_date": modifyDate,
  };
}
