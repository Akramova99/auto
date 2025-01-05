import 'dart:convert';

import 'package:auto/data/model/bilet_id_my_model.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/service/network_service.dart';

part 'medium_controller_state.dart';

class MediumControllerCubit extends Cubit<MediumControllerState> {
  MediumControllerCubit() : super(MediumControllerInitial());

  void parsingMediumController(int id) async {
    try {
      emit(MediumControllerLoading());
      String? response =
          await NetworkService.MEDIUM_CONTROLLER_METHOD((id + 1).toString());
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(MediumControllerError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }

      final List<dynamic> jsonData =
          json.decode(response); // JSONni List<dynamic> ga o'zgartirish
      final List<QuestionElement1> questions = jsonData
          .map((item) => QuestionElement1.fromJson(item))
          .toList(); // Har bir elementni QuestionElement'ga parsing qilish

      emit(MediumControllerLoaded(questions));
    } catch (e) {
      emit(MediumControllerError("An unexpected error occurred: $e"));
    }
  }
}
