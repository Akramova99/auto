import 'dart:ui';

import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/logic/time/time_display.dart';
import 'package:auto/view/utils/custom_styles.dart';
import 'package:auto/view/widgets/tab_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../logic/every_wrong_tests/every_wrong_cubit.dart';
import '../../logic/name/name_for_wrong_test_cubit.dart';
import '../widgets/answer2.dart';

class EveryWrongTestPage extends StatefulWidget {
  static const String id = "EveryWrongTestPage";

  const EveryWrongTestPage({super.key});

  @override
  State<EveryWrongTestPage> createState() => _EveryWrongTestPageState();
}

class _EveryWrongTestPageState extends State<EveryWrongTestPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EveryWrongTestsCubit, EveryWrongTestsState>(
      builder: (context, state) {
        if (state is EveryWrongTestLoading) {
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
        if (state is EveryWrongTestLoaded) {
          Logger().i("Seen");

          return DefaultTabController(
            // Use a UniqueKey to force rebuild when the state changes
            key: UniqueKey(),
            length: state.wrongQuestion.length,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  spacing: 15,
                  children: [
                    TimeDisplayPage(
                      initialTime: 25,
                    ),
                    Column(
                      children: [
                        Text("Ким хато қилган:",
                            style: CustomStyles.appBarStyle),
                        BlocBuilder<StringCubit, String>(
                          builder: (context, state) {
                            return Text(state, style: CustomStyles.appBarStyle);
                          },
                        ),
                      ],
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
                                  state.wrongQuestion.length,
                                  (index) {
                                    context.read<StringCubit>().updateString(
                                        state.wrongQuestion[index].name);
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
                                  state.wrongQuestion.length,
                                  (index) {
                                    return BlocBuilder<EveryWrongTestsCubit,
                                        EveryWrongTestsState>(
                                      builder: (context, state) {
                                        Logger().e(state);
                                        if (state is EveryWrongTestError) {
                                          Logger().e(state.message);
                                        }

                                        if (state is EveryWrongTestLoading) {
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

                                        if (state is EveryWrongTestLoaded) {
                                          Logger().i("KO'rindi");
                                          return Column(
                                            children: [
                                              Answers2(
                                                myIndex: index,
                                                questions: state.wrongQuestion,
                                              ),
                                            ],
                                          );
                                        }

                                        return Scaffold(
                                          body: Center(
                                            child: Text(
                                                "Something went wrong:${state.toString()}"),
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

        return Scaffold(
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
