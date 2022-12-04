// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  QuizModel({
    required this.title,
    required this.choice,
    required this.answerId,
  });

  String title;
  List<Choice> choice;
  int answerId;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        title: json["title"],
        choice:
            List<Choice>.from(json["choice"].map((x) => Choice.fromJson(x))),
        answerId: json["answerID"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "choice": List<dynamic>.from(choice.map((x) => x.toJson())),
        "answerID": answerId,
      };
}

class Choice {
  Choice({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["ID"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "title": title,
      };
}
