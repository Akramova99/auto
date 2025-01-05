import 'package:auto/data/constantans/app_constantans.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/bilet_id_my_model.dart';

class Answers extends StatefulWidget {
  final int myIndex;
  final List<QuestionElement1> questions;

  const Answers({super.key, required this.questions, required this.myIndex});

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    _loadSelectedAnswer(); // Saved answerni SharedPreferences dan yuklash
  }

  // Saqlangan javobni SharedPreferences dan yuklash
  Future<void> _loadSelectedAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAnswerIndex = prefs.getInt('selectedAnswer2_${widget.myIndex}');
      Logger().i("yanan ishladi");
    });
  }

  // Tanlangan javobni SharedPreferences ga saqlash
  Future<void> _saveSelectedAnswer(int index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedAnswer2_${widget.myIndex}', index);
  }

  @override
  void dispose() {
    super.dispose();
   // _clearAllAnswersData(); // Widget tark etilayotganda SharedPreferencesdagi javobni o'chirish
  }

  // SharedPreferencesdan tanlangan javobni o'chirish
  Future<void> _clearAllAnswersData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('selectedAnswer2_${widget.myIndex}');
  }


  @override
  Widget build(BuildContext context) {
    String answerText = "";
    Logger().d(widget.myIndex);
    final TabController tabController = DefaultTabController.of(context)!;

    return BlocBuilder<TabIndexCubit, TabIndexState>(
      builder: (context, state) {
        return Column(
          children: [
            widget.questions[widget.myIndex].image != null
                ? SizedBox(
              height: 260,
              child: Image.network(
                fit: BoxFit.cover,
                height: 200,
                "https://api.rulionline.uz/storage/${widget.questions[widget.myIndex].image}",
              ),
            )
                : const SizedBox(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              color: Colors.black38,
              child: Center(
                child: Text(
                  widget.questions[widget.myIndex].question.getAnswersByLanguage(
                      AppConstantans.currentLanguage),
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              widget.questions[widget.myIndex].answers.answer.uz.length,
              itemBuilder: (context, index) {
                Logger().e(AppConstantans.currentLanguage);

                answerText = widget.questions[widget.myIndex].answers.answer
                    .getAnswersByLanguage(AppConstantans.currentLanguage)[index];
                Logger().d("$answerText:${answerText.length}");

                return InkWell(
                  onTap: () async {
                    setState(() {
                      selectedAnswerIndex = index;
                    });

                    // Saqlangan javobni SharedPreferences ga saqlash
                    await _saveSelectedAnswer(index);

                    if (widget.questions[widget.myIndex].answers.status == index + 1) {
                      context.read<TabIndexCubit>().trueAnswer(widget.myIndex);
                    } else {
                      context.read<TabIndexCubit>().falseAnswer(widget.myIndex);
                    }

                    // Bir necha soniya kutishdan keyin keyingi tabga o'tish
                    Future.delayed(const Duration(seconds: 1), () {
                      final tabController = DefaultTabController.of(context);
                      if (tabController != null &&
                          tabController.index < widget.questions.length - 1) {
                        tabController.animateTo(tabController.index + 1);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.black38,
                          child: Center(
                            child: Text(
                              "F${(index + 1).toString()}",
                              style: const TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: answerText.length < 68 ? 50 : null,
                          width: 300,
                          color: _getBackgroundColor(index),
                          child: Center(
                            child: Text(
                              answerText,
                              style: const TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Color _getBackgroundColor(int index) {
    if (selectedAnswerIndex == null) {
      return Colors.grey; // Tanlanmagan javoblar uchun rang
    } else if (selectedAnswerIndex == index) {
      // Agar tanlangan javob to'g'ri bo'lsa
      if (widget.questions[widget.myIndex].answers.status == index + 1) {
        return Colors.green; // To'g'ri javob
      } else {
        return Colors.red; // Noto'g'ri javob
      }
    } else if (widget.questions[widget.myIndex].answers.status == index + 1) {
      return Colors.green; // To'g'ri javobni ko'rsatish
    } else {
      return Colors.grey; // Tanlanmagan javoblar uchun rang
    }
  }
}

