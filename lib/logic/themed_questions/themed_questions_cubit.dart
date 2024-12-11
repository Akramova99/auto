import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/test_of_lesson_id.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'themed_questions_state.dart';

class ThemedQuestionsCubit extends Cubit<ThemedQuestionsState> {
  ThemedQuestionsCubit() : super(ThemedQuestionsInitial());

  void parsingLessonsQuessions(int id) async {
    try {
      emit(ThemedQuestionLoading());
      String? response = await NetworkService.TEST_LESSON_METHOD(id.toString(), {});
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(ThemedQuestionError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }

      //emit(ThemedQuestionLoaded(NetworkService.biletResponse(response)));
       emit(ThemedQuestionLoaded2(NetworkService.testOfLessons(response)));
    } catch (e) {
      emit(ThemedQuestionError("An unexpected error occurred: $e"));
    }
  }

  
}
