import 'package:auto/logic/random/random_test_cubit.dart';
import 'package:auto/logic/random_exam/random_exam_cubit.dart';
import 'package:auto/logic/sign_in/sign_in_cubit.dart';
import 'package:auto/logic/sign_up/sign_up_cubit.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:auto/logic/themed_questions/themed_questions_cubit.dart';
import 'package:auto/logic/topic_test/topic_test_cubit.dart';
import 'package:auto/view/pages/auth_pages/sign_in_screen.dart';
import 'package:auto/view/pages/auth_pages/sign_up_screen.dart';
import 'package:auto/view/pages/main_pages/exam_page.dart';
import 'package:auto/view/pages/main_pages/themed_questions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/all_lessons/all_lessons_cubit.dart';
import 'view/pages/bilet_trenirovka.dart';
import 'view/pages/home_page.dart';
import 'view/pages/pass_exam.dart';
import 'view/pages/random_test.dart';
import 'view/pages/suggestion_page.dart';
import 'view/pages/topic_exam.dart';

void main() {
  //NASSIB BSA Riverpod BN QILAMIZ

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
            BlocProvider(
          create: (context) => SignInCubit(),
        ),
        BlocProvider(
          create: (context) => AllLessonsCubit(),
        ),
        BlocProvider(
          create: (context) => TopicTestCubit(),
        ),
        BlocProvider(
          create: (context) => TabIndexCubit(),
        ),
        BlocProvider(
          create: (context) => ThemedQuestionsCubit(),
        ),
        BlocProvider(
          create: (context) => RandomTestsCubit(),
        ),
        BlocProvider(
          create: (context) => RandomExamsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            // SignInScreen(),
            SignUpScreen(),
        // const HomePage(),
        routes: {
          HomePage.id: (context) => const HomePage(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          SignInScreen.id: (context) => const SignInScreen(),
          BiletTrainer.id: (context) => const BiletTrainer(),
          PassExam.id: (context) => const PassExam(),
          RandomTestPage.id: (context) => const RandomTestPage(),
          Suggestion.id: (context) => const Suggestion(),
          TopicExam.id: (context) => const TopicExam(),
          RandomExamPage.id: (context) => const RandomExamPage(),
          ThemedQuestionPage.id: (context) => const ThemedQuestionPage(),
        },
      ),
    );
  }
}
