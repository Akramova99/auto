part of 'all_lessons_cubit.dart';

@immutable
sealed class AllLessonsState {

}

final class AllLessonsInitial extends AllLessonsState {
}

class AllLessonLoading extends AllLessonsState {}

class AllLessonLoaded extends AllLessonsState {
  final List<AllLesson2> lessons;
  AllLessonLoaded(this.lessons);
}

class AllLessonError extends AllLessonsState{
  final String message;
  AllLessonError(this.message);
}
