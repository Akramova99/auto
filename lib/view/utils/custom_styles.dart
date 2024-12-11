import 'package:auto/view/utils/extensions/size.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomStyles {
  static TextStyle? pageTitle =
  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle?   dataTitle =
  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white,fontFamily: "Poppins");
  static TextStyle team =
  const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  static TextStyle appBarStyle =
  const TextStyle(fontSize: 17.52, fontWeight: FontWeight.w600,fontFamily: "Poppins");
  static TextStyle teamName = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w400, color: Colors.green);
  static TextStyle text =
  const TextStyle(fontSize: 24.53, fontWeight: FontWeight.w600,fontFamily: "Poppins");
  static TextStyle popText =
  const TextStyle(fontSize: 12.27, fontWeight: FontWeight.w400,fontFamily: "Poppins");
  static TextStyle interThin = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w200,
    fontSize: 14.w,
    color: AppColors.c232D3A,
  );
  static TextStyle interLight = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w300,
    fontSize: 14.w,
    color: AppColors.c232D3A,
  );
  static TextStyle interRegular = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    fontSize: 16.w,
    color: AppColors.c232D3A,
  );
  static TextStyle interMedium = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w500,
    fontSize: 16.w,
    color: AppColors.c232D3A,
  );

  static TextStyle interSemiBold = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 16.w,
    color: AppColors.c232D3A,
  );

  static TextStyle interBold = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w700,
    fontSize: 16.w,
    color: AppColors.c232D3A,
  );

  static TextStyle interBlack = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w800,
    fontSize: 16.w,
    color: AppColors.c232D3A,
  );

  static TextStyle appBarStyles = TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 20.w,
    color: AppColors.c171,
  );
}
