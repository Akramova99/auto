import 'dart:developer';

import 'package:auto/data/service/db_service.dart';
import 'package:auto/logic/sign_in/sign_in_cubit.dart';
import 'package:auto/view/pages/home_page.dart';
import 'package:auto/view/utils/extensions/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';

import '../../../data/constantans/app_constantans.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_styles.dart';
import '../../utils/toast.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_passwordfield.dart';
import '../../widgets/sub_text.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "SignInScreen";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  String countryPhone = '';
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.appBgColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBgColor,
          foregroundColor: AppColors.appBgColor,
          title: Text(
            "Kirish",
            style: CustomStyles.interBold.copyWith(
              fontSize: 20.w,
              color: AppColors.c212121,
            ),
          ),
          centerTitle: true,
          shadowColor: AppColors.greyColor,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.getH(),
                const SubText(data: 'Telefon raqam'),
                10.boxH(),
                IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefon Raqam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFFEBF0FF), width: 1),
                    ),
                  ),
                  initialCountryCode: 'UZ',
                  onChanged: (phone) {
                    log(phone.completeNumber);
                    Logger().w(phone.number);
                    setState(() {
                      countryPhone = phone.countryCode;
                    });
                    Logger().w(countryPhone);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    "Parol",
                    style: CustomStyles.interSemiBold
                        .copyWith(color: AppColors.black),
                  ),
                ),
                GlobalPasswordField(
                  title: '●●●●●●●●●',
                  icon: const Icon(Icons.lock),
                  controller: passwordController,
                  validate: AppConstantans.passwordRegExp,
                ),
                GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //     context, RouteNames.sign_up);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Parolni unitdingizmi? ",
                        style: CustomStyles.interSemiBold.copyWith(
                            fontWeight: FontWeight.w500, color: AppColors.cF8),
                      ),
                    )),
                BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    if (state is SignInInitial) {
                      return GlobalButton(
                        onTap: () async {
                          context.read<SignInCubit>().login(
                              countryPhone + phoneController.text.toString(),
                              passwordController.text.toString());
                        },
                        text: "Kirish",
                        color: AppColors.cE3E9ED,
                        textColor: AppColors.black,
                      );
                    }

                    if (state is SignInLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SignInFailure) {
                      ToastService.showError(state.errorMessage);
                    }
                    if (state is SignInSuccess) {
                      DbService.saveToken(state.loginResponse.accessToken!);
                      DbService.getToken();
                      Logger().e(DbService.getToken());
                      //TokenManager.getToken();
                      ToastService.showSuccess("Muvaffaqiyatli kirdingiz");

                      // Navigator'ni post frame ichida chaqirish
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      });
                    }

                    return GlobalButton(
                      onTap: () async {
                        context.read<SignInCubit>().login(
                            countryPhone + phoneController.text.toString(),
                            passwordController.text.toString());
                      },
                      text: "Kirish",
                      color: AppColors.cE3E9ED,
                      textColor: AppColors.black,
                    );
                  },
                ),
                20.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Akkauntingiz yo'qmi?",
                      style: CustomStyles.interSemiBold
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ro'yxatdan o'tish  ",
                          style: CustomStyles.interSemiBold.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.cF8),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
