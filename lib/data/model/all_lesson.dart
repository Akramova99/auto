

import 'dart:convert';


String welcomeToJson(List<AllLesson> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllLesson {
  int id;
  double bob;
  String lesson;
  DateTime createdAt;
  DateTime updatedAt;

  AllLesson({
    required this.id,
    required this.bob,
    required this.lesson,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllLesson.fromJson(Map<String, dynamic> json) => AllLesson(
    id: json["id"],
    bob: json["bob"]?.toDouble(),
    lesson: json["lesson"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bob": bob,
    "lesson": lesson,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class AllLesson2 {
  final int id;
  final int bob;
  final int count;
  final String name;

  AllLesson2({
    required this.id,
    required this.bob,
    required this.count,
    required this.name,
  });

  factory AllLesson2.fromJson(Map<String, dynamic> json) {
    return AllLesson2(
      id: json['id'] as int,
      bob: json['bob'] as int,
      count: json['count'] as int,
      name: json['name'] as String, // BU YERDA XATO BO'LISHI MUMKIN
    );
  }
}
