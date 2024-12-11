import 'dart:ui';

import 'package:auto/data/constantans/app_constantans.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/logic/topic_test/topic_test_cubit.dart';
import 'package:auto/view/widgets/answers.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:auto/view/widgets/tab_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class TestPage extends StatefulWidget {
  final int biletId;
  const TestPage({super.key, required this.biletId});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var items = ["Uzb", "Rus"];
  String myValue = "Uzb";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConstantans.tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: MakeBox(
                      text: "  ${widget.biletId} - bilet  "),
                ),
                onTap: () {
                  //   Navigator.pushReplacementNamed(context, BiletTrainer.id);
                  //  Navigator.pop(context);
                },
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    iconSize: 35,
                    value: myValue,
                    items: items.map(buildDropdownItem).toList(),
                    onChanged: (value) => setState(() {
                          myValue = value!;
                        })),
              )
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
                            child: BlocBuilder<TabIndexCubit, TabIndexState>(
                              builder: (context, state) {
                                return TabBar(
                                  tabAlignment: TabAlignment.start,
                                  dividerColor: Colors.transparent,
                                  indicatorColor: Colors.white,
                                  isScrollable: true,
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.white,
                                  tabs: List<Widget>.generate(
                                      AppConstantans.tabTitles.length, (index) {
                                    final isRight = state is TabIndexInitial
                                        ? state.tabStates[index]
                                        : null;
                                    return Tab(
                                      child: TabElement(
                                        tabItem: (index + 1).toString(),
                                        isRight: isRight,
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 3000,
                            child: TabBarView(
                              children: List<Widget>.generate(
                                  AppConstantans.tabTitles.length, (index) {
                                return BlocBuilder<TopicTestCubit,
                                    TopicTestState>(
                                  builder: (context, state) {
                                    Logger().d(state);
                                    if (state is TopicTestError) {
                                      Logger().d(state.message);
                                    }

                                    if (state is TopicTestLoading) {
                                      //  cubit.parsingBiletTest(1);
                                      Logger().d(
                                          "bajarildi"); // Pass the id (1 in this case)
                                      return const Column(
                                        children: [
                                          SizedBox(height: 50),
                                          SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              )),
                                        ],
                                      );
                                    }

                                    if (state is TopicTestLoaded2) {
                                      Logger().i("KO'rindi");
                                      return Column(
                                        children: [
                                          // Text(AppConstantans.tabTitles[index]
                                          //     .toString()),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     tabIndexCubit.trueAnswer(index);
                                          //   },
                                          //   child: const Icon(Icons.check),
                                          // ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     tabIndexCubit.falseAnswer(
                                          //         index);
                                          //   },
                                          //   child: const Icon(
                                          //       Icons.backspace_sharp),
                                          // ),
                                          Answers(
                                            myIndex: index,
                                            questions:
                                                state.lessons.data.questions,
                                          )
                                        ],
                                      );
                                    }

                                    return const Center(
                                      child: Text("Something went wrong"),
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

  DropdownMenuItem<String> buildDropdownItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ));
}
