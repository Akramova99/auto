class QuestionElement1 {
  int id;
  int biletId;
  int questionId;
  QuestionQuestion question;
  String? image;
  Answer1 answers;

  QuestionElement1({
    required this.id,
    required this.biletId,
    required this.questionId,
    required this.question,
    this.image,
    required this.answers,
  });

  factory QuestionElement1.fromJson(Map<String, dynamic> json) => QuestionElement1(
        id: json["id"],
        biletId: json["bilet_id"],
        questionId: json["question_id"],
        question: QuestionQuestion.fromJson(json["question"]),
        image: json["photo"],
        answers: Answer1.fromJson(json["answers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bilet_id": biletId,
        "question_id": questionId,
        "question": question.toJson(),
        "photo": image,
        "answers": answers.toJson(),
      };
}

class QuestionQuestion {
  String oz;
  String uz;
  String ru;

  QuestionQuestion({
    required this.oz,
    required this.uz,
    required this.ru,
  });

  factory QuestionQuestion.fromJson(Map<String, dynamic> json) => QuestionQuestion(
        oz: json["oz"],
        uz: json["uz"],
        ru: json["ru"],
      );

  Map<String, dynamic> toJson() => {
        "oz": oz,
        "uz": uz,
        "ru": ru,
      };
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

class Answer1 {
  int status;
  int answerId;
  AnswerContent answer;

  Answer1({
    required this.status,
    required this.answerId,
    required this.answer,
  });

  factory Answer1.fromJson(Map<String, dynamic> json) => Answer1(
        status: json["status"],
        answerId: json["answer_id"],
        answer: AnswerContent.fromJson(json["answer"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "answer_id": answerId,
        "answer": answer.toJson(),
      };
}

class AnswerContent {
  List<String> oz;
  List<String> uz;
  List<String> ru;

  AnswerContent({
    required this.oz,
    required this.uz,
    required this.ru,
  });

  factory AnswerContent.fromJson(Map<String, dynamic> json) => AnswerContent(
        oz: List<String>.from(json["oz"].map((x) => x)),
        uz: List<String>.from(json["uz"].map((x) => x)),
        ru: List<String>.from(json["ru"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "oz": List<dynamic>.from(oz.map((x) => x)),
        "uz": List<dynamic>.from(uz.map((x) => x)),
        "ru": List<dynamic>.from(ru.map((x) => x)),
      };
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
