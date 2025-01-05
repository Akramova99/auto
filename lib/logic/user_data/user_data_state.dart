part of 'user_data_cubit.dart';

@immutable

sealed class UserDataState {

}

final class UserDataInitial extends UserDataState {
}

class UserDataLoading extends UserDataState {}



class UserDataLoaded extends UserDataState {
  final UserData user;
  UserDataLoaded(this.user);
}

class UserDataError extends UserDataState{
  final String message;
  UserDataError(this.message);
}
