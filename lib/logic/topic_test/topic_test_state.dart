part of 'topic_test_cubit.dart';



@immutable
sealed class TopicTestState {

}

final class TopicTestInitial extends TopicTestState {
}

class TopicTestLoading extends TopicTestState {}

class TopicTestLoaded extends TopicTestState {
  final List <BiletId> lessons;
  TopicTestLoaded(this.lessons);
}

class TopicTestLoaded2 extends TopicTestState {
  final List<QuestionElement1> lessons;
  TopicTestLoaded2(this.lessons);
}


class TopicTestError extends TopicTestState{
  final String message;
  TopicTestError(this.message);
}
