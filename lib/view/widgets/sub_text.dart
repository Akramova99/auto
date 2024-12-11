import 'package:auto/view/utils/extensions/size.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class SubText extends StatelessWidget {
  const SubText({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: TextStyle(
      color: AppColors.c212121,
      fontWeight: FontWeight.w600,
      fontSize: 16.w,
    ),);
  }
}
