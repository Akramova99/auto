import 'package:auto/data/model/test_of_lesson_id.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'my_wrong_state.dart';

class MyWrongTestsCubit extends Cubit<MyWrongTestsState> {
  MyWrongTestsCubit() : super(MyWrongTestsInitial());

  void parsingLessonsQuessions(int id) async {
    try {
      emit(MyWrongTestLoading());
      String? response = await NetworkService.TEST_LESSON_METHOD(id.toString(), {});
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(MyWrongTestError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }

      //emit(MyWrongTestLoaded(NetworkService.biletResponse(response)));
       emit(MyWrongTestLoaded(NetworkService.testOfLessons(response)));
    } catch (e) {
      emit(MyWrongTestError("An unexpected error occurred: $e"));
    }
  }

  
}
