import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/model/random_test.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

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

      //emit(RandomTestLoaded(NetworkService.biletResponse(response)));
       emit(RandomTestLoaded2(NetworkService.randomTest(response)));
    } catch (e) {
      emit(RandomTestError("An unexpected error occurred: $e"));
    }
  }

  
}
