class QuestionData {
  final int id;
  final Question question;
  final int biletId;
  final int questionId;
  final int lessonId;
  final String name;
  final String? photo;
  final Answers answers;

  QuestionData({
    required this.id,
    required this.question,
    required this.biletId,
    required this.questionId,
    required this.lessonId,
    required this.name,
    this.photo,
    required this.answers,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json["id"],
      question: Question.fromJson(json["question"]),
      biletId: json["bilet_id"],
      questionId: json["question_id"],
      lessonId: json["lesson_id"],
      name: json["name"],
      photo: json["photo"],
      answers: Answers.fromJson(json["answers"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question.toJson(),
      "bilet_id": biletId,
      "question_id": questionId,
      "lesson_id": lessonId,
      "name": name,
      "photo": photo,
      "answers": answers.toJson(),
    };
  }
}

class Question {
  final String oz;
  final String uz;
  final String ru;

  Question({
    required this.oz,
    required this.uz,
    required this.ru,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      oz: json["oz"],
      uz: json["uz"],
      ru: json["ru"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "oz": oz,
      "uz": uz,
      "ru": ru,
    };
  }
    // Dinamik til bo'yicha javoblarni olish uchun metod
  String getAnswersByLanguage(String language) {
    switch (language) {
      case "ru":
        return ru;
      case "oz":
        return oz;
      case "uz":
      default:
        return uz;
    }
  }
}

class Answers {
  final int status;
  final int answerId;
  final Answer answer;

  Answers({
    required this.status,
    required this.answerId,
    required this.answer,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      status: json["status"],
      answerId: json["answer_id"],
      answer: Answer.fromJson(json["answer"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "answer_id": answerId,
      "answer": answer.toJson(),
    };
  }
}

class Answer {
  final List<String> oz;
  final List<String> uz;
  final List<String> ru;

  Answer({
    required this.oz,
    required this.uz,
    required this.ru,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      oz: List<String>.from(json["oz"]),
      uz: List<String>.from(json["uz"]),
      ru: List<String>.from(json["ru"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "oz": oz,
      "uz": uz,
      "ru": ru,
    };
  }
    // Dinamik til bo'yicha javoblarni olish uchun metod
  List<String> getAnswersByLanguage(String language) {
    switch (language) {
      case "ru":
        return ru;
      case "oz":
        return oz;
      case "uz":
      default:
        return uz;
    }
  }
}
