class QuestionsModel {
  int id;
  String title;
  String status;
  String date;
  String time;
  List<GetOption> getOptions;

  QuestionsModel({
    required this.id,
    required this.title,
    required this.status,
    required this.date,
    required this.time,
    required this.getOptions,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    date: json["date"],
    time: json["time"],
    getOptions: List<GetOption>.from(json["get_options"].map((x) => GetOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "date": date,
    "time": time,
    "get_options": List<dynamic>.from(getOptions.map((x) => x.toJson())),
  };
}

class GetOption {
  int id;
  int questionId;
  String option;
  bool selectedIndex;

  GetOption({
    required this.id,
    required this.questionId,
    required this.option,
     this.selectedIndex=false
  });

  factory GetOption.fromJson(Map<String, dynamic> json) => GetOption(
    id: json["id"],
    questionId: json["question_id"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "option": option,
  };
}
