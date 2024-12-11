import 'package:flutter/services.dart';

import '../../view/utils/app_colors.dart';

class AppConstantans {
  static String placeHolder = "";
  static RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegExp = RegExp(r"^(?=.*[A-Z]).{8,}$");
  static RegExp telegramOnlyLettersAndNumbersWithoutFirstCapital =
  RegExp(r'@([A-Za-z0-9_]{5,32})');
  static RegExp noMinusOrLettersNoZero = RegExp(r'^[^0a-zA-Z-]');
  static RegExp textRegExp = RegExp("[a-zA-Z]");
  static RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  static SystemUiOverlayStyle getOverlayStyle() =>
      const SystemUiOverlayStyle(statusBarColor: AppColors.transparent);

  static const List<int> tabTitles = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];



  static List<String> items() =>
      List.generate(37, (index) => "Bilet ${index+1}");
}
