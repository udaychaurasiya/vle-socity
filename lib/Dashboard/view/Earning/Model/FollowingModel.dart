// To parse this JSON data, do
//
//     final followingModel = followingModelFromJson(jsonString);

import 'dart:convert';

FollowingModel followingModelFromJson(String str) => FollowingModel.fromJson(json.decode(str));

String followingModelToJson(FollowingModel data) => json.encode(data.toJson());

class FollowingModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum> data;

  FollowingModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    required this.data,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  String? isVerify;
  String? profile;
  String? stateName;
  String? cityName;
  String? zipCode;

  Datum({
    this.id,
    this.name,
    this.isVerify,
    this.profile,
    this.stateName,
    this.cityName,
    this.zipCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"]??"",
    isVerify: json["is_verify"]??"",
    profile: json["profile"]??"",
    stateName: json["state_name"]??"",
    cityName: json["city_name"]??"",
    zipCode: json["zip_code"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_verify": isVerify,
    "profile": profile,
    "state_name": stateName,
    "city_name": cityName,
    "zip_code": zipCode,
  };
}
