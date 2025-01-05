import 'dart:ui';

import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/logic/themed_questions/themed_questions_cubit.dart';
import 'package:auto/logic/time/time_display.dart';
import 'package:auto/view/widgets/answers.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:auto/view/widgets/tab_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ThemedQuestionPage extends StatefulWidget {
  static const String id = "ThemedQuestionPage";

  const ThemedQuestionPage({super.key});

  @override
  State<ThemedQuestionPage> createState() => _ThemedQuestionPageState();
}

class _ThemedQuestionPageState extends State<ThemedQuestionPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemedQuestionsCubit, ThemedQuestionsState>(
      builder: (context, state) {
        if (state is ThemedQuestionLoading) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/img.png"))),
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                      ),
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        if (state is ThemedQuestionLoaded2) {
          Logger().i("Seen");

          return DefaultTabController(
            // Use a UniqueKey to force rebuild when the state changes
            key: UniqueKey(),
            length: state.allLessons.data.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    TimeDisplayPage(initialTime: state.allLessons.data.length,),
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: MakeBox(text: " Testni yakunlash "),
                      ),
                      onTap: () {
                        // Optionally, navigate back or any other logic
                        Navigator.pop(context);

                        // Optionally, you could also emit a new state using Bloc to reload if needed
                        context.read<TabIndexCubit>().updateState();
                      },
                    ),

                  ],
                ),
                centerTitle: true,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/img.png"),
                  ),
                ),
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
                            colors: [Colors.white60, Colors.white],
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 17),
                              width: 327,
                              child: TabBar(
                                tabAlignment: TabAlignment.start,
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.white,
                                tabs: List<Widget>.generate(
                                  state.allLessons.data.length,
                                  (index) {
                                    return BlocBuilder<TabIndexCubit,
                                        TabIndexState>(
                                      builder: (context, state) {
                                        Logger().d("index $index");

                                        final isRight = state is TabIndexInitial
                                            ? state.tabStates[index]
                                            : null;

                                        return Tab(
                                          child: TabElement(
                                            tabItem: (index + 1).toString(),
                                            isRight: isRight,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 3000,
                              child: TabBarView(
                                children: List<Widget>.generate(
                                  state.allLessons.data.length,
                                  (index) {
                                    return BlocBuilder<ThemedQuestionsCubit,
                                        ThemedQuestionsState>(
                                      builder: (context, state) {
                                        Logger().e(state);
                                        if (state is ThemedQuestionError) {
                                          Logger().e(state.message);
                                        }

                                        if (state is ThemedQuestionLoading) {
                                          Logger().d("bajarildi");
                                          return const Column(
                                            children: [
                                              SizedBox(height: 50),
                                              SizedBox(
                                                height: 40,
                                                width: 40,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        if (state is ThemedQuestionLoaded2) {
                                          Logger().i("KO'rindi");
                                          return Column(
                                            children: [
                                              Answers(
                                                myIndex: index,
                                                questions:
                                                    state.allLessons.data,
                                              ),
                                            ],
                                          );
                                        }

                                        return  Scaffold(
                                          body: Center(
                                            child: Text("Something went wrong:${state.toString()}"),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return  Scaffold(
          body: Center(
            child: Text("Something went wrong :${state.toString()}"),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildDropdownItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ));
}
