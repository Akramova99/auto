part of 'themed_questions_cubit.dart';

@immutable
sealed class ThemedQuestionsState {

}

final class ThemedQuestionsInitial extends ThemedQuestionsState {
}

class ThemedQuestionLoading extends ThemedQuestionsState {}



class ThemedQuestionLoaded2 extends ThemedQuestionsState {
  final TestOfLessons allLessons;
  ThemedQuestionLoaded2(this.allLessons);
}

class ThemedQuestionError extends ThemedQuestionsState{
  final String message;
  ThemedQuestionError(this.message);
}
