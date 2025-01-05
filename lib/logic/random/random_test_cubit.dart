import 'dart:convert';

import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/random_test.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../data/model/bilet_id_my_model.dart';

part 'random_test_state.dart';

class RandomTestsCubit extends Cubit<RandomTestsState> {
  RandomTestsCubit() : super(RandomTestsInitial());

  void parsingRandom() async {
    try {
      emit(RandomTestLoading());
      String? response = await NetworkService.RANDOM_TEST_METHOD( {});
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(RandomTestError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }
    final List<dynamic> jsonData = json.decode(response); // JSONni List<dynamic> ga o'zgartirish
      final List<QuestionElement1> questions = jsonData
          .map((item) => QuestionElement1.fromJson(item))
          .toList(); // Har bir elementni QuestionElement'ga parsing qilish

      //emit(RandomTestLoaded(NetworkService.biletResponse(response)));
       emit(RandomTestLoaded2(questions));
    } catch (e) {
      emit(RandomTestError("An unexpected error occurred: $e"));
    }
  }

  
}
