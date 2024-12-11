import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../data/model/auth_models.dart';
import '../../data/model/login_response.dart';
import '../../data/service/network_service.dart';
import '../../view/utils/formaters/formatters.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  void login(String phone, String password) async {
    try {
      emit(SignInLoading());
      String cleanedNumber = AppInputFormatters.formatPhoneNumber(
          phone
         );
         
      if (cleanedNumber.startsWith('998')) {
        cleanedNumber = cleanedNumber.substring(3); // Remove the first 3 characters (998)
      }

      LoginModel user = LoginModel(
        phoneNumber: cleanedNumber,
        password: password,
      );
      Logger().i('Requesting URL: $cleanedNumber');
      // Use the toJson() method to convert the UserModel to a Map
      Map<String, String> params = user.toJson();
      Logger().i('Requesting URL: $params');
      // Call the LOGIN function
      String? response = await NetworkService.LOGIN(params);

      Logger().i(response.runtimeType);
      Logger().i(response);

      if (response == null) {
        emit(SignInFailure(
            "Iltimos telefon yoki parolingizni to'g'ri kiriting"));
        return;
      }

      emit(SignInSuccess(NetworkService.loginResponse(response)));
    } catch (e) {
      emit(SignInValidationError("Xatolik kuzatilmoqda: $e"));
    }
  }
}
