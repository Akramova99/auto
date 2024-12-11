// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:auto/data/model/random_test.dart';


String welcomeToJson(BiletId data) => json.encode(data.toJson());

class BiletId {
  Data data;

  BiletId({
    required this.data,
  });

  factory BiletId.fromJson(Map<String, dynamic> json) => BiletId(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String bilet;
  List<QuestionElement> questions;

  Data({
    required this.id,
    required this.bilet,
    required this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    bilet: json["bilet"],
    questions: List<QuestionElement>.from(json["questions"].map((x) => QuestionElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bilet": bilet,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class QuestionElement {
  int id;
  int biletId;
  int questionId;
  QuestionQuestion question;
  String? image;
  List<AnswerElement> answers;

  QuestionElement({
    required this.id,
    required this.biletId,
    required this.questionId,
    required this.question,
    required this.image,
    required this.answers,
  });

  factory QuestionElement.fromJson(Map<String, dynamic> json) => QuestionElement(
    id: json["id"],
    biletId: json["bilet_id"],
    questionId: json["question_id"],
    question: QuestionQuestion.fromJson(json["question"]),
    image: json["image"],
    answers: List<AnswerElement>.from(json["answers"].map((x) => AnswerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bilet_id": biletId,
    "question_id": questionId,
    "question": question.toJson(),
    "image": image,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}





class QuestionQuestion {
  String uz;
  String ru;

  QuestionQuestion({
    required this.uz,
    required this.ru,
  });

  factory QuestionQuestion.fromJson(Map<String, dynamic> json) => QuestionQuestion(
    uz: json["uz"],
    ru: json["ru"],
  );

  Map<String, dynamic> toJson() => {
    "uz": uz,
    "ru": ru,
  };
}
