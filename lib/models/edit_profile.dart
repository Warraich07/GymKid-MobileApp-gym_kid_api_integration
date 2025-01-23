class EditProfileModel {
  int id;
  String name;
  String image;
  String email;
  List<String> reason;
  List<String> goals;
  String gym;
  String age;
  String gender;

  EditProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.reason,
    required this.goals,
    required this.gym,
    required this.age,
    required this.gender,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    reason: List<String>.from(json["reason"].map((x) => x)),
    goals: List<String>.from(json["goals"].map((x) => x)),
    gym: json["gym"],
    age: json["age"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
    "reason": List<dynamic>.from(reason.map((x) => x)),
    "goals": List<dynamic>.from(goals.map((x) => x)),
    "gym": gym,
    "age": age,
    "gender": gender,
  };
}
