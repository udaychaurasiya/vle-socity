// To parse this JSON data, do
//
//     final couponCodeModel = couponCodeModelFromJson(jsonString);

import 'dart:convert';

CouponCodeModel couponCodeModelFromJson(String str) => CouponCodeModel.fromJson(json.decode(str));

String couponCodeModelToJson(CouponCodeModel data) => json.encode(data.toJson());

class CouponCodeModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  CouponCodeModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  factory CouponCodeModel.fromJson(Map<String, dynamic> json) => CouponCodeModel(
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
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? couponNo;
  String? usersId;
  String? amount;
  String? remark;
  DateTime? expDate;
  String? status;
  DateTime? addDate;
  String? modifyDate;

  Datum({
    this.id,
    this.couponNo,
    this.usersId,
    this.amount,
    this.remark,
    this.expDate,
    this.status,
    this.addDate,
    this.modifyDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    couponNo: json["coupon_no"],
    usersId: json["users_id"],
    amount: json["amount"],
    remark: json["remark"],
    expDate: DateTime.parse(json["exp_date"]),
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "coupon_no": couponNo,
    "users_id": usersId,
    "amount": amount,
    "remark": remark,
    "exp_date": expDate!.toIso8601String(),
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
  };
}
