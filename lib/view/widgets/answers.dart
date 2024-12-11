import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/logic/tab_index/tab_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class Answers extends StatefulWidget {
  final int myIndex;
  final List<QuestionElement> questions;
  const Answers({super.key, required this.questions, required this.myIndex});

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    String answerText = "";
    Logger().d(widget.myIndex);
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
                      "https://rulionline.uz/api/storage/${widget.questions[widget.myIndex].image}",
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              color: Colors.black38,
              child: Center(
                child: Text(
                  widget.questions[widget.myIndex].question.uz,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget
                  .questions[widget.myIndex].answers[0].answer.uz.length,
              //questions.questions[myIndex].answers[0].answer.uz.length
              itemBuilder: (context, index) {
                answerText = widget
                    .questions[widget.myIndex].answers[0].answer.uz[index];
              Logger().d("$answerText:${answerText.length}");
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedAnswerIndex = index;
                    });
                    if (widget
                            .questions[widget.myIndex].answers[0].status ==
                        index + 1) {
                      context.read<TabIndexCubit>().trueAnswer(widget.myIndex);
                    } else {
                      context.read<TabIndexCubit>().falseAnswer(widget.myIndex);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height:50,
                          width: 50,
                          color: Colors.black38,
                          child: Center(
                            child: Text(
                              "F${(index + 1).toString()}",
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding:const EdgeInsets.symmetric(horizontal: 5),
                          height: answerText.length<68? 50:null,
                          width: 300,
                          color: _getBackgroundColor(index),
                          child: Center(
                            child: Text(
                              answerText,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white),
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
      return Colors.grey; // Default color for unselected answers
    } else if (selectedAnswerIndex == index) {
      // Check if the selected answer is correct
      if (widget.questions[widget.myIndex].answers[0].status ==
          index + 1) {
        return Colors.green; // Correct answer
      } else {
        return Colors.red; // Incorrect answer
      }
    } else {
      return Colors.grey; // Unselected answers
    }
  }
}
