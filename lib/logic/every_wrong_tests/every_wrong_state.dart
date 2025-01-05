part of 'every_wrong_cubit.dart';

@immutable
sealed class EveryWrongTestsState {}

final class EveryWrongTestsInitial extends EveryWrongTestsState {}

class EveryWrongTestLoading extends EveryWrongTestsState {}

class EveryWrongTestLoaded extends EveryWrongTestsState {
  final List<QuestionData> wrongQuestion;

  EveryWrongTestLoaded(this.wrongQuestion);
}

class EveryWrongTestError extends EveryWrongTestsState {
  final String message;

  EveryWrongTestError(this.message);
}
class IndexLoading extends EveryWrongTestsState {}
class ChangeIndex extends EveryWrongTestsState {
  final String nameIndex;

  ChangeIndex(this.nameIndex);
}
