import 'dart:ui';

import 'package:auto/logic/random/random_test_cubit.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/view/widgets/answers.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:auto/view/widgets/tab_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class RandomTestPage extends StatefulWidget {
  static const String id = "RandomTestPage";

  const RandomTestPage({super.key});

  @override
  State<RandomTestPage> createState() => _RandomTestPageState();
}

class _RandomTestPageState extends State<RandomTestPage> {
  var items = ["Uzb", "Rus"];
  String myValue = "Uzb";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomTestsCubit, RandomTestsState>(
      builder: (context, state) {
        if (state is RandomTestLoading) {
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
        if (state is RandomTestLoaded2) {
          return DefaultTabController(
            length: state.randomTest .data.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: MakeBox(text: "  Testni yakunlash  "),
                      ),
                      onTap: () {
                        Navigator.pop(context);
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
                                    child: TabBar(
                                      tabAlignment: TabAlignment.start,
                                      dividerColor: Colors.transparent,
                                      indicatorColor: Colors.white,
                                      isScrollable: true,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.white,
                                      tabs: List<Widget>.generate(
                                          state.randomTest.data.length,
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
                                        state.randomTest.data.length, (index) {
                                      return BlocBuilder<RandomTestsCubit,
                                          RandomTestsState>(
                                        builder: (context, state) {
                                          Logger().d(state);
                                          if (state is RandomTestError) {
                                            Logger().e(state.message);
                                          }

                                          if (state is RandomTestLoading) {
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

                                          if (state is RandomTestLoaded2) {
                                            Logger().i("KO'rindi");
                                            return Column(
                                              children: [
                                                Answers(
                                                  myIndex: index,
                                                  questions:
                                                      state.randomTest.data,
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
