import 'dart:developer';

import 'package:auto/view/pages/auth_pages/sign_in_screen.dart';
import 'package:auto/view/utils/extensions/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:logger/logger.dart';

import '../../../data/constantans/app_constantans.dart';
import '../../../data/service/db_service.dart';
import '../../../logic/sign_up/sign_up_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_styles.dart';
import '../../utils/toast.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_field.dart';
import '../../widgets/sub_text.dart';
import '../home_page.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "SignUpScreen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool SignUp = false;
  String countryPhone = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController validateControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
        //,
        backgroundColor: AppColors.appBgColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBgColor,
          foregroundColor: AppColors.appBgColor,
          // leading: InkWell(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: Icon(
          //     Icons.arrow_back,
          //     color: AppColors.blackColor,
          //   ),
          // ),
          title: Text(
            'Ro\'yxatdan o\'tish',
            style: CustomStyles.interBold.copyWith(
              fontSize: 20.w,
              color: AppColors.c212121,
            ),
          ),
          centerTitle: true,
          shadowColor: AppColors.greyColor,
          elevation: 0.5,
        ),
        body: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            const SubText(data: 'Ism'),
            10.boxH(),
            GlobalTextField(
              hintText: 'Ismingizni kiriting',
              controller: nameController,
            ),
            20.boxH(),
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

            // const SubText(data: 'Email'),
            // 10.boxH(),
            // GlobalTextField(
            //   hintText: 'Emailingizni kiriting',
            //   keyboardType: TextInputType.emailAddress,
            //   controller: emailController,
            // ),
            // 20.boxH(),
            const SubText(data: 'Parol'),
            10.boxH(),
            GlobalTextField(
              hintText: 'Parolingizni kiriting',
              controller: passwordControlller,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible1 = !isVisible1;
                  });
                },
                icon: isVisible1
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              obscureText: isVisible1,
            ),
            20.boxH(),
            const SubText(data: 'Parolni tasdiqlang'),
            10.boxH(),
            GlobalTextField(
              hintText: 'Parolingizni kiriting',
              controller: validateControlller,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible2 = !isVisible2;
                  });
                },
                icon: isVisible2
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              obscureText: isVisible2,
            ),
            15.boxH(),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Siz allaqachon ro'yxatdan o'tganmisiz?",
                  style: CustomStyles.interSemiBold
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: Text(
                      "Tizimga Kirish",
                      style: CustomStyles.interSemiBold.copyWith(
                          fontWeight: FontWeight.w500, color: AppColors.cF8),
                    )),
              ],
            ),
            30.boxH(),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                if (state is SignUpInitial) {
                  return GlobalButton(
                    onTap: () {
                      bool nameCheck = nameController.text.trim().length > 3;
                      bool phoneCheck =
                          phoneController.text.trim().length == 17;
                      bool match = AppConstantans.emailRegExp
                              .hasMatch(emailController.text.trim()) &&
                          AppConstantans.passwordRegExp
                              .hasMatch(passwordControlller.text.trim()) &&
                          AppConstantans.passwordRegExp
                              .hasMatch(validateControlller.text.trim());

                      bool validate =
                          passwordControlller.text == validateControlller.text;
                      setState(() {
                        SignUp = nameCheck && phoneCheck && match && validate;
                      });

                      context.read<SignUpCubit>().registration(
                          nameController.text.trim(),
                          countryPhone + phoneController.text.toString(),
                          passwordControlller.text.toString());

                      // if (!nameCheck) {
                      //   UtilityFunctions.showSnackBar("Ismingizni kiriting", context);
                      // } else if (!phoneCheck) {
                      //   UtilityFunctions.showSnackBar(
                      //       "Raqamingizni kiriting", context);
                      // } else if (!match) {
                      //   UtilityFunctions.showSnackBar(
                      //       "Email yoki parolni qayta kiriting", context);
                      // } else if (!validate) {
                      //   UtilityFunctions.showSnackBar(
                      //       "Parollaringiz mos kelmayapti", context);
                      // }
                      // Navigator.pushNamed(context, RouteNames.otpScreen);
                    },
                    text: 'Ro\'yxatdan o\'tish',
                    color: SignUp ? AppColors.cF8 : AppColors.cE3E9ED,
                    textColor: SignUp ? AppColors.white : AppColors.c434E58,
                  );
                }

                if (state is SignUpLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SignUpFailure) {
                  ToastService.showError(state.errorMessage);
                }
                if (state is SignUpSuccess) {
                  DbService.saveToken(state.registerResponse.accessToken!);

                  if (DbService.getLoggedIn()) {
                    ToastService.showSuccess(
                        "Muvaffaqiyatli ro'yxatdan o'tdingiz");
                  }

                  // Defer navigation to the next microtask
                  Future.microtask(() {
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  });
                }

                return GlobalButton(
                  onTap: () {
                    bool nameCheck = nameController.text.trim().length > 3;
                    bool phoneCheck = phoneController.text.trim().length == 17;
                    bool match = AppConstantans.emailRegExp
                            .hasMatch(emailController.text.trim()) &&
                        AppConstantans.passwordRegExp
                            .hasMatch(passwordControlller.text.trim()) &&
                        AppConstantans.passwordRegExp
                            .hasMatch(validateControlller.text.trim());

                    bool validate =
                        passwordControlller.text == validateControlller.text;
                    setState(() {
                      SignUp = nameCheck && phoneCheck && match && validate;
                    });

                    context.read<SignUpCubit>().registration(
                        nameController.text.trim(),
                        countryPhone + phoneController.text.toString(),
                        passwordControlller.text.toString());

                    // if (!nameCheck) {
                    //   UtilityFunctions.showSnackBar("Ismingizni kiriting", context);
                    // } else if (!phoneCheck) {
                    //   UtilityFunctions.showSnackBar(
                    //       "Raqamingizni kiriting", context);
                    // } else if (!match) {
                    //   UtilityFunctions.showSnackBar(
                    //       "Email yoki parolni qayta kiriting", context);
                    // } else if (!validate) {
                    //   UtilityFunctions.showSnackBar(
                    //       "Parollaringiz mos kelmayapti", context);
                    // }
                    // Navigator.pushNamed(context, RouteNames.otpScreen);
                  },
                  text: 'Ro\'yxatdan o\'tish',
                  color: SignUp ? AppColors.cF8 : AppColors.cE3E9ED,
                  textColor: SignUp ? AppColors.white : AppColors.c434E58,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
