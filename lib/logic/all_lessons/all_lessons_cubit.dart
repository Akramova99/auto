import 'package:auto/data/model/all_lesson.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'all_lessons_state.dart';

class AllLessonsCubit extends Cubit<AllLessonsState> {
  AllLessonsCubit() : super(AllLessonsInitial());

  void parsingLessonsName() async {
    try {
      emit(AllLessonLoading());
      String response = await NetworkService.GET_LESSON_METHOD();

      Logger().i(" $response");

      if (response == null) {
        emit(AllLessonError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }else{
        Logger().i(response.runtimeType);

        emit(AllLessonLoaded(NetworkService.parsingResponse(response)));


      }


    } catch (e) {
      emit(AllLessonError("An unexpected error occurred: $e"));
      Logger().i("An unexpected error occurred: $e ");

    }
  }
}
