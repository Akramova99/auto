// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/test_of_lesson_id.dart';

DifferentTests welcomeFromJson(String str) => DifferentTests.fromJson(json.decode(str));

String welcomeToJson(DifferentTests data) => json.encode(data.toJson());

class DifferentTests {
  Lesson lesson;
  List<QuestionElement> data;

  DifferentTests({
    required this.lesson,
    required this.data,
  });

  factory DifferentTests.fromJson(Map<String, dynamic> json) => DifferentTests(
    lesson: Lesson.fromJson(json["lesson"]),
    data: List<QuestionElement>.from(json["data"].map((x) => QuestionElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lesson": lesson.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


