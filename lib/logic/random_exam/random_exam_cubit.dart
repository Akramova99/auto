import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/test_of_lesson_id.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'random_exam_state.dart';

class RandomExamsCubit extends Cubit<RandomExamsState> {
  RandomExamsCubit() : super(RandomExamsInitial());

  void randomExam(int id) async {
    try {
      emit(RandomExamLoading());
      String? response = await NetworkService.GET_TEST_METHOD(id.toString(), {});
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(RandomExamError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }

      //emit(RandomExamLoaded(NetworkService.biletResponse(response)));
       emit(RandomExamLoaded2(NetworkService.testOfLessons(response)));
    } catch (e) {
      emit(RandomExamError("An unexpected error occurred: $e"));
    }
  }

  
}
