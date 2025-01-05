import 'dart:ui';

import 'package:auto/data/constantans/app_constantans.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:auto/data/service/url_launch.dart';
import 'package:auto/logic/every_wrong_tests/every_wrong_cubit.dart';
import 'package:auto/logic/logout/logout_cubit.dart';
import 'package:auto/logic/pass_exam/pass_exam_cubit.dart';
import 'package:auto/logic/random/random_test_cubit.dart';
import 'package:auto/logic/user_data/user_data_cubit.dart';
import 'package:auto/view/pages/auth_pages/sign_up_screen.dart';
import 'package:auto/view/pages/bilet_trenirovka.dart';
import 'package:auto/view/pages/pass_exam.dart';
import 'package:auto/view/pages/random_test.dart';
import 'package:auto/view/pages/topic_trenirovka.dart';
import 'package:auto/view/widgets/box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dialog/custom_diolog.dart';
import '../utils/app_colors.dart';
import 'oraliq_nazorat/interim_control.dart';
import 'topic_exam.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void response() {
    NetworkService.header();
  }

  @override
  void didChangeDependencies() {
    response();
    context.read<UserDataCubit>().parsingUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff4147D5),
                ),
                child: Column(
                  children: [
                    Text(
                      'Сизнинг_Профилингиз'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        if (state is UserDataLoaded) {
                          return Column(
                            children: [
                              Text(
                                state.user.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: "PlexSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                    fontSize: 22),
                              ),
                              Text(
                                state.user.roleId == 2
                                    ? "${"Обуна_тугаш_вақти".tr()}:${state.user.finishTime}"
                                    : state.user.roleId == 3
                                        ? "Актив_обуначи_эмассиз!".tr()
                                        : "Админ".tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: "PlexSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                    fontSize: 22),
                              ),
                            ],
                          );
                        }
                        if (state is UserDataLoading) {
                          return  Text(
                            "${"Юкланмоқда".tr()}...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "PlexSans",
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Тиллар'.tr()),

              ),
              ListTile(
                title: Text("Russian".tr()),
                onTap: () {
                  setState(() {
                    context.setLocale(Locale('ru', 'RU'));
AppConstantans.currentLanguage="ru";
                  });
                },
              ),
              ListTile(
                title: Text("Krill".tr()),
                onTap: () {
                  setState(() {
                    context.setLocale(Locale('uz', 'Cyrl'));
                    AppConstantans.currentLanguage="uz";
                  });
                },
              ),
              ListTile(
                title: Text("Uzbek".tr()),
                onTap: () {
                  setState(() {
                    context.setLocale(Locale('uz', 'Latn'));
                    AppConstantans.currentLanguage="oz";
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Ҳисобдан чиқиш'.tr()),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocListener<LogoutCubit, LogoutState>(
                        listener: (context, state) {
                          if (state is LogoutSuccess) {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          } else if (state is LogoutLoading) {
                            // Yuklanish holatini ko'rsatish (optional)
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          }
                        },
                        child: CustomDialog(
                          title: "Ҳисобдан чиқиш".tr(),
                          content:
                              "Сиз тизимдан чиқарилиб, барча маълумотларингиз қурилмадан ўчирилади!".tr(),
                          button1Text: "Ҳа".tr(),
                          button2Text: "Йўқ".tr(),
                          button1Function: () {
                            context.read<LogoutCubit>().logout();
                          },
                          button2Function: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLoaded) {
                return Text(
                  state.user.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "PlexSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                );
              }
              if (state is UserDataLoading) {
                return  Text(
                  "${"Юкланмоқда".tr()}...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "PlexSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                );
              }
              return const SizedBox();
            },
          ),
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
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //  height: MediaQuery.of(context).size.height - 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          try {
                            await LaunchUrl.httpsCall(
                                "//t.me/rulionline_uz_bot");
                          } catch (e) {
                            // Xatolikni ekranda ko'rsatish yoki loglash
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Xatolik: $e')),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Бизнинг телеграм бот".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "PlexSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.lightBlueColor),
                            ),
                            Icon(Icons.android, color: AppColors.lightBlueColor)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await LaunchUrl.httpsCall("///t.me/rulionlineuz");
                          } catch (e) {
                            // Xatolikni ekranda ko'rsatish yoki loglash
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Xatolik: $e')),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Бизнинг телеграм канал".tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "PlexSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.lightBlueColor),
                            ),
                            Icon(Icons.telegram,
                                color: AppColors.lightBlueColor)
                          ],
                        ),
                      ),
                       Text(
                        "Мазкур тестлар Ўзбекистон Республикаси ЙҲХБ томонидан тасдиқланган расмий билетлар асосида тузилган".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "PlexSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              child:  MakeBox(
                                  text: "Мавзу бўйича тренировкани бошлаш".tr(),),
                              onTap: () {
                                // response();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TopicTrainer(isExam: false)));
                              },
                            ),
                            GestureDetector(
                              child:  MakeBox(
                                  text: "Мавзулар бўйича имтиҳон топшириш".tr()
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TopicTrainer(isExam: true)));
                                // Navigator.pushReplacementNamed(
                                //     context, TopicExam.id);
                              },
                            ),
                            GestureDetector(
                              child:  MakeBox(text: "Оралиқ Назорат".tr()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InterimControl()));
                              },
                            ),
                            GestureDetector(
                              child:  MakeBox(
                                  text:
                                      "Билетлар бўйича тренировкани бошлаш".tr()),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, BiletTrainer.id);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child:  MakeBox(text: "Рандом Тест".tr()),
                                  onTap: () {
                                    context
                                        .read<RandomTestsCubit>()
                                        .parsingRandom();
                                    Navigator.pushNamed(
                                        context, RandomTestPage.id);
                                  },
                                ),
                                GestureDetector(
                                  child:
                                       MakeBox(text: "Имтиҳон Топшириш".tr()
                                      ),
                                  onTap: () {
                                    context.read<PassExamCubit>().passExam();
                                    Navigator.pushNamed(context, PassExam.id);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child:  MakeBox(
                                      text: "Барча Хато қилинган саволлар".tr()),
                                  onTap: () {
                                    context
                                        .read<EveryWrongTestsCubit>()
                                        .parsingWrongTests();
                                    Navigator.pushNamed(
                                        context, EveryWrongTestPage.id);
                                  },
                                ),
                                GestureDetector(
                                  child:  MakeBox(
                                      text: "Менинг хато саволларим".tr()),
                                  onTap: () {
                                    context.read<PassExamCubit>().passExam();
                                    Navigator.pushNamed(context, PassExam.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await LaunchUrl.httpsCall("//t.me/Sayfillayev_dev");
                          } catch (e) {
                            // Xatolikni ekranda ko'rsatish yoki loglash
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Xatolik: $e')),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          // constraints: const BoxConstraints(maxWidth: 400.0), // Set a maximum width

                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Таклиф ва шикоятлар учун".tr(),
                                style: TextStyle(
                                    color: AppColors.lightBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     try {
                      //       await LaunchUrl.httpsCall(
                      //           "//t.me/farrukh_nabiyev");
                      //     } catch (e) {
                      //       // Xatolikni ekranda ko'rsatish yoki loglash
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text('Xatolik: $e')),
                      //       );
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(
                      //         horizontal: 15, vertical: 10),
                      //     // constraints: const BoxConstraints(maxWidth: 400.0), // Set a maximum width
                      //
                      //     height: 50.0,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           "Ekspress kurs",
                      //           style: TextStyle(
                      //               color: AppColors.lightBlueColor,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 15),
                      //         ),
                      //         SizedBox(
                      //           width: 20,
                      //         ),
                      //         Icon(
                      //           Icons.auto_stories,
                      //           color: AppColors.lightBlueColor,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
