import 'dart:ui';

import 'package:auto/data/constantans/app_constantans.dart';
import 'package:auto/logic/topic_test/topic_test_cubit.dart';
import 'package:auto/view/pages/main_pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/box.dart';
import 'home_page.dart';

class BiletTrainer extends StatefulWidget {
  static const String id = "BiletTrainer";

  const BiletTrainer({super.key});

  @override
  State<BiletTrainer> createState() => _BiletTrainerState();
}

class _BiletTrainerState extends State<BiletTrainer> {
  String myValue = "Bilet 1";
  int myIndex = 1;

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
                      margin: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                            },
                            child: const Text(
                              "Ortga",
                              style: TextStyle(
                                  color: Color(0xff4147D5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: 50.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            iconSize: 35,
                                            value: myValue,
                                            items: AppConstantans.items()
                                                .map(buildMenuItems)
                                                .toList(),
                                            onChanged: (value) => setState(() {
                                                  myValue = value!;

                                                  myIndex = int.parse(
                                                      myValue.split(" ").last);
                                                })),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: MakeBox(text: "  Boshlash  "),
                                onTap: () {
                                  context
                                      .read<TopicTestCubit>()
                                      .parsingBiletTest(myIndex);

                                  // Navigator.pushNamed(
                                  //     context, TestPage.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TestPage(biletId: myIndex)));
                                },
                              ),
                            ],
                          ),
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
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20),
      ));
}
