import 'dart:ui';

import 'package:auto/logic/random_exam/random_exam_cubit.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/logic/time/time_display.dart';
import 'package:auto/view/widgets/answers.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:auto/view/widgets/tab_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class RandomExamPage extends StatefulWidget {
  static const String id = "RandomExamPage";

  const RandomExamPage({super.key});

  @override
  State<RandomExamPage> createState() => _RandomExamPageState();
}

class _RandomExamPageState extends State<RandomExamPage> {
  var items = ["Uzb", "Rus"];
  String myValue = "Uzb";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomExamsCubit, RandomExamsState>(
      builder: (context, state) {
        if (state is RandomExamLoading) {
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
        if (state is RandomExamLoaded2) {
          return DefaultTabController(
            length: state.allLessons.data.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    TimeDisplayPage(initialTime: 25,),
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: MakeBox(text: "  Testni yakunlash  "),
                      ),
                      onTap: () {
                        Navigator.pop(context);
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
                    ListView(
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                      top: 17,
                                    ),
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
                                           

                                            final isRight =
                                                state is TabIndexInitial
                                                    ? state.tabStates[index]
                                                    : null;

                                            return Tab(
                                              child: TabElement(
                                                tabItem:(index+1) 
                                                    .toString(),
                                                isRight: isRight,
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    )),
                                const SizedBox(height: 24),
                                SizedBox(
                                  height: 3000,
                                  child: TabBarView(
                                    children: List<Widget>.generate(
                                        state.allLessons.data.length, (index) {
                                      return BlocBuilder<RandomExamsCubit,
                                          RandomExamsState>(
                                        builder: (context, state) {
                                          Logger().d(state);
                                          if (state is RandomExamError) {
                                            Logger().e(state.message);
                                          }

                                          if (state is RandomExamLoading) {
                                            //  cubit.parsingBiletTest(1);
                                            Logger().d(
                                                "bajarildi"); // Pass the id (1 in this case)
                                            return const Column(
                                              children: [
                                                SizedBox(height: 50),
                                                SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            );
                                          }

                                          if (state is RandomExamLoaded2) {
                                            Logger().i("KO'rindi");
                                            return Column(
                                              children: [
                                                Answers(
                                                  myIndex: index,
                                                  questions:
                                                      state.allLessons.data,
                                                )
                                              ],
                                            );
                                          }

                                          return const Scaffold(
                                            body: Center(
                                              child:
                                                  Text("Something went wrong"),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: Text("Something went wrong"),
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
