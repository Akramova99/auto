part of 'random_test_cubit.dart';

@immutable
sealed class RandomTestsState {

}

final class RandomTestsInitial extends RandomTestsState {
}

class RandomTestLoading extends RandomTestsState {}

class RandomTestLoaded extends RandomTestsState {
  final List<BiletId> lessons;
  RandomTestLoaded(this.lessons);
}

class RandomTestLoaded2 extends RandomTestsState {
  final RandomTest randomTest;
  RandomTestLoaded2(this.randomTest);
}

class RandomTestError extends RandomTestsState{
  final String message;
  RandomTestError(this.message);
}
