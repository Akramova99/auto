import 'dart:ui';

import 'package:auto/logic/medium_controller/medium_controller_cubit.dart';
import 'package:auto/view/pages/home_page.dart';
import 'package:auto/view/pages/oraliq_nazorat/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constantans/app_constantans.dart';
import '../../widgets/box.dart';


class InterimControl extends StatefulWidget {
  

  const InterimControl({super.key,});

  @override
  State<InterimControl> createState() => _InterimControlState();
}

class _InterimControlState extends State<InterimControl> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: MakeBox(text: "  Nazoratni yakunlash  "),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
            ),
          
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
                  // ignore: deprecated_member_use
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
               ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return TestTile1(
                                index: index,
                                lesson:AppConstantans.mavzular[index],
                                function: () {
                                  // widget.isExam?
                                  //  context
                                  //     .read<RandomExamsCubit>()
                                  //     .randomExam(
                                  //         state.lessons[index].id):
                                 context
                                .read<MediumControllerCubit>()
                                .parsingMediumController(
                                   index,
                                );
                                          
                                
                                   
                                },
                              );
                            },
                            itemCount: AppConstantans.mavzular.length)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
