import 'package:auto/data/model/bilet_id_lessons.dart';
import 'package:auto/data/service/network_service.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'topic_test_state.dart';

class TopicTestCubit extends Cubit<TopicTestState> {
  TopicTestCubit() : super(TopicTestInitial());

  Future<void> parsingBiletTest(int index) async {
    try {
      emit(TopicTestLoading());

      String? response =
          await NetworkService.BILET_TEST_METHOD(index.toString(), {});
      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(TopicTestError(
            "Failed to load tests of bilet. Please check your internet connection."));
        return;
      }
      emit(TopicTestLoaded2(NetworkService.fromJsonjon(response)));
      Logger().i(1);
    } catch (e) {
      emit(TopicTestError("An unexpected error occurred: $e"));
    }
  }
}
