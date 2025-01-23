import 'package:flutter/cupertino.dart';

class PostsModel {
  int id;
  int userId;
  String message;
  List<String> topics;
  String creationDate;
  String creationTime;
  String time;
  int totalReplies;
  int totalViews;
  int totalLikes;
  int totalShare;
  GetUser getUser;
  List<GetComment> getComment;
  TextEditingController textEditingController;
  bool isLiked;
  bool isSeen;

  PostsModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.topics,
    required this.creationDate,
    required this.creationTime,
    required this.time,
    required this.totalReplies,
    required this.totalViews,
    required this.totalLikes,
    required this.totalShare,
    required this.getUser,
    required this.getComment,
    required this.textEditingController,
    required this.isLiked,
    required this.isSeen
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    id: json["id"],
    userId: json["user_id"],
    message: json["message"],
    topics: List<String>.from(json["topics"].map((x) => x)),
    creationDate: json["creation_date"],
    creationTime: json["creation_time"],
    time: json["time"],
    totalReplies: json["total_replies"],
    totalViews: json["total_views"],
    totalLikes: json["total_likes"],
    totalShare: json["total_share"],
    getUser: GetUser.fromJson(json["get_user"]),
    getComment: List<GetComment>.from(json["get_comment"].map((x) => GetComment.fromJson(x))),
    textEditingController: TextEditingController(),
    isLiked: json["isLiked"],
    isSeen:json["isSeen"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "message": message,
    "topics": List<dynamic>.from(topics.map((x) => x)),
    "creation_date": creationDate,
    "creation_time": creationTime,
    "time": time,
    "total_replies": totalReplies,
    "total_views": totalViews,
    "total_likes": totalLikes,
    "total_share": totalShare,
    "get_user": getUser.toJson(),
    "get_comment": List<dynamic>.from(getComment.map((x) => x.toJson())),
    "isLiked":isLiked,
    "isSeen":isSeen
  };
}

class GetComment {
  int id;
  int userId;
  int postId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  GetUser getUser;

  GetComment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.getUser,
  });

  factory GetComment.fromJson(Map<String, dynamic> json) => GetComment(
    id: json["id"],
    userId: json["user_id"],
    postId: json["post_id"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    getUser: GetUser.fromJson(json["get_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "get_user": getUser.toJson(),
  };
}

class GetUser {
  int id;
  String name;
  String? image;

  GetUser({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
