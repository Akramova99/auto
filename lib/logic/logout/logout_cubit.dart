import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/service/db_service.dart';
import '../../data/service/network_service.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  void logout() async {
    try {
      emit(LogoutLoading());

      String? response = await NetworkService.LOGOUT();

      Logger().i(response);

      if (response == null) {
        emit(LogoutFailure(
            "Hisobingizdan chiqib bo'lmadi"));
        return;
      }
      // JSON'ni Map formatiga o'girish
      Map<String, dynamic> responseMap = json.decode(response);

      // Ma'lumotlarni olish
      String message = responseMap['message'];
      bool success = responseMap['success'];

      Logger().i('Xabar: $message');
      Logger().i('Muvaffaqiyat: $success');
      emit(LogoutSuccess(responseMap));
      DbService.clear();
    } catch (e) {
      emit(LogoutFailure("Xatolik kuzatilmoqda: $e"));
    }
  }
}
