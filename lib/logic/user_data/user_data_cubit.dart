import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_data.dart';
import '../../data/service/network_service.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  void parsingUserData() async {
    try {
      emit(UserDataLoading());
      String? response =
          await NetworkService.GET_USER_DATA();
      Logger().i(response);

      if (response == null) {
        emit(UserDataError(
            "Failed to load lessons. Please check your internet connection."));
        return;
      }

      UserData userData(String str) => UserData.fromJson(json.decode(str));
      emit(UserDataLoaded(userData(response)));
    } catch (e) {
      emit(UserDataError("An unexpected error occurred: $e"));
    }
  }
}
