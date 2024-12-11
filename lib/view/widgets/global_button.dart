import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../utils/app_colors.dart';
import '../utils/custom_styles.dart';
import '../utils/extensions/size.dart';


class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color = AppColors.cF8,
    this.textColor = AppColors.white,
  });

  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            text,
            style: CustomStyles.interBold.copyWith(
              fontSize: 16.w,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
