// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'bilet_id_my_model.dart';

String welcomeToJson(TestOfLessons data) => json.encode(data.toJson());

class TestOfLessons {
  String lesson;
  List<QuestionElement1> data;

  TestOfLessons({
    required this.lesson,
    required this.data,
  });

  factory TestOfLessons.fromJson(Map<String, dynamic> json) => TestOfLessons(
        lesson: json["lesson"],
        data: List<QuestionElement1>.from(
            json["data"].map((x) => QuestionElement1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lesson": lesson,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TestOfLessons1 {
  Lesson1 lesson;
  List<QuestionElement1> data;

  TestOfLessons1({
    required this.lesson,
    required this.data,
  });

  factory TestOfLessons1.fromJson(Map<String, dynamic> json) => TestOfLessons1(
        lesson: Lesson1.fromJson(json["lesson"]),
        data: List<QuestionElement1>.from(
            json["data"].map((x) => QuestionElement1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lesson": lesson,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Lesson1 {
  int id;
  int bob;
  int count;
  String name;

  Lesson1({
    required this.id,
    required this.bob,
    required this.count,
    required this.name,
  });

  factory Lesson1.fromJson(Map<String, dynamic> json) => Lesson1(
        id: json["id"],
        bob: json["bob"],
        count: json["count"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bob": bob,
        "count": count,
        "name": name,
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
