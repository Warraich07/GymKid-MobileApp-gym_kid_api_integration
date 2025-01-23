class PreviousAnsweredModel {
  int id;
  String title;
  String status;
  int totalAnswers;
  String date;
  String time;
  List<GetOption> getOptions;

  PreviousAnsweredModel({
    required this.id,
    required this.title,
    required this.status,
    required this.totalAnswers,
    required this.date,
    required this.time,
    required this.getOptions,
  });

  factory PreviousAnsweredModel.fromJson(Map<String, dynamic> json) => PreviousAnsweredModel(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    totalAnswers: json["total_answers"],
    date: json["date"],
    time: json["time"],
    getOptions: List<GetOption>.from(json["get_options"].map((x) => GetOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "total_answers": totalAnswers,
    "date": date,
    "time": time,
    "get_options": List<dynamic>.from(getOptions.map((x) => x.toJson())),
  };
}

class GetOption {
  int id;
  int questionId;
  String option;
  int totalAnswers;

  GetOption({
    required this.id,
    required this.questionId,
    required this.option,
    required this.totalAnswers,
  });

  factory GetOption.fromJson(Map<String, dynamic> json) => GetOption(
    id: json["id"],
    questionId: json["question_id"],
    option: json["option"],
    totalAnswers: json["total_answers"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "option": option,
    "total_answers": totalAnswers,
  };
}
