import 'package:auto/data/model/auth/auth_models.dart';
import 'package:auto/data/model/auth/register_response.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/service/db_service.dart';
import '../../data/service/network_service.dart';
import '../../view/utils/formaters/formatters.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
    void registration(String name,String phone, String password) async {
    try {
      emit(SignUpLoading());
      String cleanedNumber = AppInputFormatters.formatPhoneNumber(
          phone
         );
      // if (cleanedNumber.startsWith('998')) {
      //   cleanedNumber = cleanedNumber.substring(3); // Remove the first 3 characters (998)
      // }

      RegisterModel user = RegisterModel(name: name,phoneNumber: cleanedNumber,password: password);
      Logger().i('Requesting URL: $cleanedNumber');
      // Use the toJson() method to convert the UserModel to a Map
      Map<String, String> params = user.toJson();
      Logger().i('Requesting URL: $params');
      // Call the LOGIN function
      String? response = await NetworkService.SIGN_UP(params);

      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(SignUpFailure(
            "Iltimos telefon yoki parolingizni to'g'ri kiriting"));
        return;
      }

      emit(SignUpSuccess(NetworkService.registerResponse(response)));
      DbService.setLoggedIn(true);
    } catch (e) {
      emit(SignUpValidationError("Xatolik kuzatilmoqda: $e"));
    }
  }
}
