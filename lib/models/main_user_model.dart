class MainUserModel {
  int id;
  String name;
  String email;
  String? image;
  dynamic fcmToken;
  List<String> reason;
  List<String> goals;
  String gym;
  String age;
  String gender;
  int status;

  MainUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.reason,
    required this.goals,
    required this.gym,
    required this.age,
    required this.gender,
    required this.status,
    this.image
  });

  factory MainUserModel.fromJson(Map<String, dynamic> json) => MainUserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    fcmToken: json["fcm_token"],
    reason: List<String>.from(json["reason"].map((x) => x)),
    goals: List<String>.from(json["goals"].map((x) => x)),
    gym: json["gym"],
    age: json["age"],
    gender: json["gender"],
    status: json["status"],
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "fcm_token": fcmToken,
    "reason": List<dynamic>.from(reason.map((x) => x)),
    "goals": List<dynamic>.from(goals.map((x) => x)),
    "gym": gym,
    "age": age,
    "gender": gender,
    "status": status,
    "image":image
  };
}
