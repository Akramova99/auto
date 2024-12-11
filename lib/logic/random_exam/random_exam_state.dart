part of 'random_exam_cubit.dart';

@immutable
sealed class RandomExamsState {

}

final class RandomExamsInitial extends RandomExamsState {
}

class RandomExamLoading extends RandomExamsState {}

class RandomExamLoaded extends RandomExamsState {
  final List<BiletId> lessons;
  RandomExamLoaded(this.lessons);
}

class RandomExamLoaded2 extends RandomExamsState {
  final TestOfLessons allLessons;
  RandomExamLoaded2(this.allLessons);
}

class RandomExamError extends RandomExamsState{
  final String message;
  RandomExamError(this.message);
}
