import 'dart:convert';

import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/model/bilet_id_my_model.dart';

part 'topic_test_state.dart';



// Cubit
class TopicTestCubit extends Cubit<TopicTestState> {
  TopicTestCubit() : super(TopicTestInitial());

  Future<void> parsingBiletTest(int index) async {
    try {
      emit(TopicTestLoading());

      // Networkdan String javob olish
      String? response = await NetworkService.BILET_TEST_METHOD(index.toString(), {});

      Logger().i(response.runtimeType); // Javob turi String bo'lsa, log chiqariladi.
      Logger().i(response); // Javobni ko'rish uchun.

      if (response == null || response.isEmpty) {
        emit(TopicTestError("Failed to load tests of bilet. Please check your internet connection."));
        return;
      }

      // JSON parsing
      final List<dynamic> jsonData = json.decode(response); // JSONni List<dynamic> ga o'zgartirish
      final List<QuestionElement1> questions = jsonData
          .map((item) => QuestionElement1.fromJson(item))
          .toList(); // Har bir elementni QuestionElement'ga parsing qilish
      questions.sort((a, b) => a.id.compareTo(b.id));

      emit(TopicTestLoaded2(questions)); // Ma'lumotlar yuklanganini bildirish
      Logger().i("Parsing successful with ${questions.length} questions.");
    } catch (e) {
      emit(TopicTestError("An unexpected error occurred: $e"));
    }
  }
}

