import 'package:flutter/material.dart';

import 'time_zone.dart';

class TimeDisplayPage extends StatefulWidget {
  final int initialTime; // Vaqt parametri

  // Konstruktor orqali vaqtni required qilib olish
  TimeDisplayPage({required this.initialTime});

  @override
  _TimeDisplayPageState createState() => _TimeDisplayPageState();
}

class _TimeDisplayPageState extends State<TimeDisplayPage> {
  late int timeRemaining;

  @override
  void initState() {
    super.initState();
    timeRemaining =
        widget.initialTime*60; // Konstruktor orqali yuborilgan vaqtni o'rnatamiz
    startTimer(); // Timerni ishga tushiramiz
  }

  void startTimer() {
    // Har bir soniyada vaqtni kamaytirish
    Future.delayed(Duration(seconds: 1), () {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
        startTimer(); // Vaqtni kamaytirishni davom ettiramiz
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(Icons.timer),
        Text(
          formatTime(timeRemaining), // Kamaygan vaqtni ko'rsatish
          style: TextStyle(fontSize: 32),
        ),
      ],
    );
  }
}
