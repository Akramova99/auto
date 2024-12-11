// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:auto/data/model/bilet_id_lessons.dart';



String welcomeToJson(TestOfLessons data) => json.encode(data.toJson());

class TestOfLessons {
  Lesson lesson;
  List<QuestionElement> data;

  TestOfLessons({
    required this.lesson,
    required this.data,
  });

  factory TestOfLessons.fromJson(Map<String, dynamic> json) => TestOfLessons(
        lesson: Lesson.fromJson(json["lesson"]),
        data: List<QuestionElement>.from(json["data"].map((x) => QuestionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lesson": lesson.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Lesson {
  int bob;
  String lesson;

  Lesson({
    required this.bob,
    required this.lesson,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        bob: json["bob"],
        lesson: json["lesson"],
      );

  Map<String, dynamic> toJson() => {
        "bob": bob,
        "lesson": lesson,
      };
}
