// To parse this JSON data, do
//
//     final userProfileData = userProfileDataFromJson(jsonString);

import 'dart:convert';

CommunityModel communityModelFromJson(String str) => CommunityModel.fromJson(json.decode(str));

String communityModelToJson(CommunityModel data) => json.encode(data.toJson());

class CommunityModel {
  CommunityModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int ?status;
  String? message;
  String? limit;
  int? page;
  List<CommunityDatum>? data;

  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<CommunityDatum>.from(json["Data"].map((x) => CommunityDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CommunityDatum {
  CommunityDatum({
    this.id,
    this.postCategoryMasterId,
    this.description,
    this.addDate,
    this.postCategory,
    this.image,
    this.addById,
    this.followStatus,
    this.aslike,
    this.ttlView,
    this.ttlLike,
    this.ttlAnswer,
    this.addBy,
    this.addByPic,
    this.stateName,
    this.cityName,
    this.isSlected,
    this.likeslected,
    this.ttlMedia,
    this.ttlShare,
    this.is_verify,
    this.comments,
  });

  String? id;
  String? postCategoryMasterId;
  String? description;
  String? addDate;
  String ?postCategory;
  String? image;
  String? addById;
  String? followStatus;
  String? aslike;
  String? ttlView;
  String? ttlLike;
  String? ttlAnswer;
  String? addBy;
  String? addByPic;
  String? stateName;
  String? cityName;
  bool? isSlected;
  bool? likeslected;
  String? ttlMedia;
  String? ttlShare;
  String? is_verify;
  List<Comment>? comments;

  factory CommunityDatum.fromJson(Map<String, dynamic> json) => CommunityDatum(
    id: json["id"],
    postCategoryMasterId: json["post_category_master_id"]??"",
    description: json["description"]??"",
    addDate: json["add_date"]??"",
    postCategory: json["postCategory"]??"",
    image: json["image"]??"",
    addById: json["add_by_id"]??"",
    followStatus: json["followStatus"]??"",
    aslike: json["aslike"]??"",
    ttlView: json["ttlView"]??"",
    ttlLike: json["ttlLike"]??"",
    ttlAnswer: json["ttlAnswer"]??"",
    addBy: json["addBy"]??"",
    addByPic: json["addByPic"]??"",
    stateName: json["state_name"]??"",
    cityName: json["city_name"]??"",
    isSlected:json["followStatus"]!=null?json["followStatus"]=="Following"?false:true:false,
    likeslected:json["aslike"]!=null?json["aslike"]=="0"?false:true:false,
    ttlMedia: json["ttlMedia"]??"",
    ttlShare: json["ttlShare"]??"",
    is_verify: json["is_verify"]??"",
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_category_master_id": postCategoryMasterId,
    "description": description,
    "add_date": addDate,
    "postCategory": postCategory,
    "image": image,
    "add_by_id": addById,
    "followStatus": followStatus,
    "aslike": aslike,
    "ttlView": ttlView,
    "ttlLike": ttlLike,
    "ttlAnswer": ttlAnswer,
    "addBy": addBy,
    "addByPic": addByPic,
    "state_name": stateName,
    "city_name": cityName,
    "isSlected": isSlected,
    "likeslected": likeslected,
    "ttlShare": ttlShare,
    "is_verify": is_verify,
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}
class Comment {
  String? id;
  String? commentAddBy;
  String? postCommunityId;
  String? answer;
  DateTime? addDate;
  String? addById;
  String? ttlLike;
  String? aslike;
  String? isDelete;
  String? addBy;
  String? isVerify;
  String? profile;
  String? addByPic;

  Comment({
    this.id,
    this.commentAddBy,
    this.postCommunityId,
    this.answer,
    this.addDate,
    this.addById,
    this.ttlLike,
    this.aslike,
    this.isDelete,
    this.addBy,
    this.isVerify,
    this.profile,
    this.addByPic,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    commentAddBy: json["add_by"],
    postCommunityId: json["post_community_id"],
    answer: json["answer"],
    addDate: DateTime.parse(json["add_date"]),
    addById: json["add_by_id"],
    ttlLike: json["ttlLike"],
    aslike: json["aslike"],
    isDelete: json["isDelete"],
    addBy: json["addBy"],
    isVerify: json["is_verify"],
    profile: json["profile"],
    addByPic: json["addByPic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_by": commentAddBy,
    "post_community_id": postCommunityId,
    "answer": answer,
    "add_date": addDate!.toIso8601String(),
    "add_by_id": addById,
    "ttlLike": ttlLike,
    "aslike": aslike,
    "isDelete": isDelete,
    "addBy": addBy,
    "is_verify": isVerify,
    "profile": profile,
    "addByPic": addByPic,
  };
}