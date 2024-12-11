import 'package:auto/data/model/all_lesson.dart';
import 'package:auto/view/pages/main_pages/exam_page.dart';
import 'package:auto/view/pages/main_pages/themed_questions_page.dart';
import 'package:flutter/material.dart';

class TestTile extends StatelessWidget {
  final bool isExam;
  final AllLesson2 lesson;
  final Function function;

  const TestTile({super.key, required this.lesson, required this.function,required this.isExam});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
     !isExam?   Navigator.pushNamed(context, ThemedQuestionPage.id):
      Navigator.pushNamed(context, RandomExamPage.id);
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.cyanAccent.shade100,
              child: Text(
                lesson.id.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xff4147D5),
                ),
              ),
            ),
            title: Text(
              lesson.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
          Divider(
            indent: 80,
          ),
        ],
      ),
    );
  }
}
