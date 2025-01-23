class NotesModel {
  int id;
  int userId;
  String mood;
  List<String> reason;
  String note;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  NotesModel({
    required this.id,
    required this.userId,
    required this.mood,
    required this.reason,
    required this.note,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    id: json["id"],
    userId: json["user_id"],
    mood: json["mood"],
    reason: List<String>.from(json["reason"].map((x) => x)),
    note: json["note"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "mood": mood,
    "reason": List<dynamic>.from(reason.map((x) => x)),
    "note": note,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
