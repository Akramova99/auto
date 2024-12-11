import 'dart:ui';

import 'package:auto/data/service/network_service.dart';
import 'package:auto/logic/random/random_test_cubit.dart';
import 'package:auto/view/pages/bilet_trenirovka.dart';
import 'package:auto/view/pages/pass_exam.dart';
import 'package:auto/view/pages/random_test.dart';
import 'package:auto/view/pages/topic_trenirovka.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class HomePage extends StatelessWidget {
  static const String id = "HomePage";

  const HomePage({super.key});

  // void response() async {
  //   var lesson = await NetworkService.GET_LESSON_METHOD();
  //   Logger().i("$lesson qaaa");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height + 100,
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Mazkur testlar O'zbekiston Respublikasi YHXB tomonidan tasdiqlangan rasmiy biletlar asosida tuzilgan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "PlexSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: const MakeBox(
                                    text:
                                        "Mavzu bo'yicha trenirovkani boshlash"),
                                onTap: () {
                                  // response();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TopicTrainer(isExam: false)));
                                },
                              ),
                              GestureDetector(
                                child: MakeBox(
                                    text:
                                        "Mavzular bo'yicha imtihon topshirish"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TopicTrainer(isExam: true)));
                                  // Navigator.pushReplacementNamed(
                                  //     context, TopicExam.id);
                                },
                              ),
                              GestureDetector(
                                child: MakeBox(
                                    text:
                                        "Biletlar bo'yicha trenirovkani boshlash"),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, BiletTrainer.id);
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: MakeBox(text: "  Random Test   "),
                                    onTap: () {
                                      context
                                          .read<RandomTestsCubit>()
                                          .parsingRandom();
                                      Navigator.pushNamed(
                                          context, RandomTestPage.id);
                                    },
                                  ),
                                  GestureDetector(
                                    child:
                                        MakeBox(text: "  Imtihon Topshirish  "),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, PassExam.id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          // constraints: const BoxConstraints(maxWidth: 400.0), // Set a maximum width

                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Taklif va shikoyatlar uchun",
                                style: TextStyle(
                                    color: Color(0xff4147D5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
