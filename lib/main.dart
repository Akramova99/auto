import 'package:auto/data/service/db_service.dart';
import 'package:auto/logic/every_wrong_tests/every_wrong_cubit.dart';
import 'package:auto/logic/logout/logout_cubit.dart';
import 'package:auto/logic/medium_controller/medium_controller_cubit.dart';
import 'package:auto/logic/my_wrong_tests/my_wrong_cubit.dart';
import 'package:auto/logic/name/name_for_wrong_test_cubit.dart';
import 'package:auto/logic/pass_exam/pass_exam_cubit.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/all_lessons/all_lessons_cubit.dart';
import 'logic/user_data/user_data_cubit.dart';
import 'view/pages/bilet_trenirovka.dart';
import 'view/pages/home_page.dart';
import 'view/pages/oraliq_nazorat/medium_controller_tests.dart';
import 'view/pages/pass_exam.dart';
import 'view/pages/random_test.dart';
import 'view/pages/topic_exam.dart';

void main() async {
  //NASSIB BSA Riverpod BN QILAMIZ
  WidgetsFlutterBinding.ensureInitialized();

  await DbService.init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('uz', 'Latn'), Locale('uz', 'Cyrl'),Locale('ru', 'RU') ],
      path: 'assets/translations', // JSON fayllar joylashgan katalog
      fallbackLocale: Locale('uz', 'Cyrl'),
      child: const MyApp(),
    ),
  );
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
        BlocProvider(
          create: (context) => MediumControllerCubit(),
        ),
        BlocProvider(
          create: (context) => UserDataCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => PassExamCubit(),
        ),
        BlocProvider(
          create: (context) => EveryWrongTestsCubit(),
        ),
        BlocProvider(
          create: (context) => MyWrongTestsCubit(),
        ),
         BlocProvider(
          create: (context) => StringCubit(),
        ),
      ],
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DbService.getLoggedIn() ? const HomePage() : const SignUpScreen(),
        routes: {
          HomePage.id: (context) => const HomePage(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          SignInScreen.id: (context) => const SignInScreen(),
          BiletTrainer.id: (context) => const BiletTrainer(),
          PassExam.id: (context) => const PassExam(),
          RandomTestPage.id: (context) => const RandomTestPage(),
          EveryWrongTestPage.id: (context) => const EveryWrongTestPage(),
          RandomExamPage.id: (context) => const RandomExamPage(),
          ThemedQuestionPage.id: (context) => const ThemedQuestionPage(),
          //MediumControllerTests
          MediumControllerTests.id: (context) => const MediumControllerTests(),
        },
      ),
    );
  }
}
