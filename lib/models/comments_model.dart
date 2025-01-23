class CommentsModel {
  int id;
  int userId;
  int postId;
  String comment;
  GetUser getUser;

  CommentsModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.comment,
    required this.getUser,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    id: json["id"],
    userId: json["user_id"],
    postId: json["post_id"],
    comment: json["comment"],
    getUser: GetUser.fromJson(json["get_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "comment": comment,
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
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
