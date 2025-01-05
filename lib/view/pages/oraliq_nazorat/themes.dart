import 'package:auto/view/pages/main_pages/exam_page.dart';
import 'package:flutter/material.dart';

import 'medium_controller_tests.dart';

class TestTile1 extends StatelessWidget {
  final int index;
  final String lesson;
  final Function function;

  const TestTile1({super.key, required this.lesson, required this.function,required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
  
      Navigator.pushNamed(context,MediumControllerTests .id);
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.cyanAccent.shade100,
              child: Text(
                (index+1).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xff4147D5),
                ),
              ),
            ),
            title: Text(
              lesson,
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
