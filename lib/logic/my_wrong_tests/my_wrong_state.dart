part of 'my_wrong_cubit.dart';

@immutable
sealed class MyWrongTestsState {

}

final class MyWrongTestsInitial extends MyWrongTestsState {
}

class MyWrongTestLoading extends MyWrongTestsState {}



class MyWrongTestLoaded extends MyWrongTestsState {
  final TestOfLessons allLessons;
  MyWrongTestLoaded(this.allLessons);
}

class MyWrongTestError extends MyWrongTestsState{
  final String message;
  MyWrongTestError(this.message);
}
