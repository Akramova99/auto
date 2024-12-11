import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/box.dart';
import 'home_page.dart';
class TopicExam extends StatefulWidget {
  static const String id = "TopicExam";

  const TopicExam({super.key});

  @override
  State<TopicExam> createState() => _TopicExamState();
}

class _TopicExamState extends State<TopicExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: MakeBox(text: "  Testni yakunlash  "),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
            ),
            Text("Imtihon",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/img.png"))),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white60, Colors.white]),
                ),
              ),
            ),
            SingleChildScrollView(
                child:  Column(
                  children: [
                    SizedBox(height: 10,),

                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
