// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'bilet_id_lessons.dart';

RandomTest welcomeFromJson(String str) => RandomTest.fromJson(json.decode(str));

String welcomeToJson(RandomTest data) => json.encode(data.toJson());

class RandomTest {
  List<QuestionElement> data;

  RandomTest({
    required this.data,
  });

  factory RandomTest.fromJson(Map<String, dynamic> json) => RandomTest(
    data: List<QuestionElement>.from(json["data"].map((x) => QuestionElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class AnswerElement {
  int status;
  int answerId;
  AnswerAnswer answer;

  AnswerElement({
    required this.status,
    required this.answerId,
    required this.answer,
  });

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
    status: json["status"],
    answerId: json["answer_id"],
    answer: AnswerAnswer.fromJson(json["answer"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "answer_id": answerId,
    "answer": answer.toJson(),
  };
}

class AnswerAnswer {
  List<String> uz;
  List<String> ru;

  AnswerAnswer({
    required this.uz,
    required this.ru,
  });

  factory AnswerAnswer.fromJson(Map<String, dynamic> json) => AnswerAnswer(
    uz: List<String>.from(json["uz"].map((x) => x)),
    ru: List<String>.from(json["ru"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "uz": List<dynamic>.from(uz.map((x) => x)),
    "ru": List<dynamic>.from(ru.map((x) => x)),
  };
}


