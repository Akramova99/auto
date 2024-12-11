part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final LoginResponse loginResponse;
  SignInSuccess(this.loginResponse);
}

final class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}

final class SignInValidationError extends SignInState {
  final String validationMessage;
  SignInValidationError(this.validationMessage);
}
