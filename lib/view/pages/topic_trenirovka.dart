import 'dart:ui';

import 'package:auto/logic/all_lessons/all_lessons_cubit.dart';
import 'package:auto/logic/random_exam/random_exam_cubit.dart';
import 'package:auto/logic/themed_questions/themed_questions_cubit.dart';
import 'package:auto/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../widgets/box.dart';
import '../widgets/tests.dart';

class TopicTrainer extends StatefulWidget {
  final bool isExam ;

  const TopicTrainer({super.key,required this.isExam});

  @override
  State<TopicTrainer> createState() => _TopicTrainerState();
}

class _TopicTrainerState extends State<TopicTrainer> {
  @override
  void didChangeDependencies() {
    context.read<AllLessonsCubit>().parsingLessonsName();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: false,
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
             Text(
              widget.isExam?
              "Lesson":"Trenirovka",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<AllLessonsCubit, AllLessonsState>(
                    builder: (context, state) {
                      if (state is AllLessonLoading) {
                        Logger().i(state);
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.white,),
                              ],
                            ),
                          ],
                        );
                      }
                      if (state is AllLessonLoaded) {
                        Logger().i("${state} AllLessonLoaded");
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TestTile(
                                isExam: widget.isExam,
                                lesson: state.lessons[index],
                                function: () {
                                  widget.isExam?
                                   context
                                      .read<RandomExamsCubit>()
                                      .randomExam(
                                          state.lessons[index].id):
                                  context
                                      .read<ThemedQuestionsCubit>()
                                      .parsingLessonsQuessions(
                                          state.lessons[index].id);
                                          
                                
                                   
                                },
                              );
                            },
                            itemCount: state.lessons.length);
                      }
                      if (state is AllLessonError) {
                        Logger().i(state);
                        return Column(
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            const Icon(
                              Icons
                                  .signal_wifi_statusbar_connected_no_internet_4_sharp,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
