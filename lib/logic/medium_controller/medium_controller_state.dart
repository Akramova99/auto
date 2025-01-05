part of 'medium_controller_cubit.dart';

@immutable

sealed class MediumControllerState {

}

final class MediumControllerInitial extends MediumControllerState {
}

class MediumControllerLoading extends MediumControllerState {}



class MediumControllerLoaded extends MediumControllerState {
  final List<QuestionElement1> tests;
  MediumControllerLoaded(this.tests);
}

class MediumControllerError extends MediumControllerState{
  final String message;
  MediumControllerError(this.message);
}
