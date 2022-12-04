import 'package:meta/meta.dart';
import 'dart:convert';

List<StatModel> statModelFromJson(String str) =>
    List<StatModel>.from(json.decode(str).map((x) => StatModel.fromJson(x)));

String statModelToJson(List<StatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatModel {
  StatModel({
    required this.quiznum,
    required this.score,
    required this.date,
    required this.time,
  });

  String quiznum;
  int score;
  String date;
  String time;

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
        quiznum: json["quiznum"],
        score: json["score"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "quiznum": quiznum,
        "score": score,
        "date": date,
        "time": time,
      };
}
