import 'dart:convert';

import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../data/model/wrong_model.dart';

part 'every_wrong_state.dart';

class EveryWrongTestsCubit extends Cubit<EveryWrongTestsState> {
  EveryWrongTestsCubit() : super(EveryWrongTestsInitial());

  void parsingWrongTests() async {
    try {
      emit(EveryWrongTestLoading());
      String? response = await NetworkService.EVERY_WRONG_TEST();
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(EveryWrongTestError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }
      final List<dynamic> jsonData =
          json.decode(response); // JSONni List<dynamic> ga o'zgartirish
      final List<QuestionData> wrongTests = jsonData
          .map((item) => QuestionData.fromJson(item))
          .toList(); // Har bir elementni QuestionElement'ga parsing qilish
      emit(EveryWrongTestLoaded(wrongTests));
    } catch (e) {
      emit(EveryWrongTestError("An unexpected error occurred: $e"));
    }
  }

  void changingIndex(nameIndex) async {
    emit(IndexLoading());

    emit(ChangeIndex(nameIndex));
  }
}
