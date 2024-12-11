import 'package:auto/view/utils/custom_styles.dart';
import 'package:auto/view/utils/extensions/size.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class GlobalPasswordField extends StatefulWidget {
  const GlobalPasswordField({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.validate,
  });

  final String title;
  final Widget icon;
  final TextEditingController controller;
  final RegExp validate;

  @override
  State<GlobalPasswordField> createState() => _GlobalPasswordFieldState();
}

class _GlobalPasswordFieldState extends State<GlobalPasswordField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.c99ABC6.withOpacity(0.18),
            blurRadius: 62,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        obscuringCharacter: "●",
        style: CustomStyles.interRegular.copyWith(fontSize: 14),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Parolingizni kiriting";
          }
          if (!widget.validate.hasMatch(value)) {
            return "Parol kiritilishi shart";
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        controller: widget.controller,
        obscureText: isVisible,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 17.h),
          prefixIcon: widget.icon,
          suffixIcon: Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: !isVisible
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.visibility_off),
              ),
            ),
          ),
          hintText: widget.title,
          hintStyle: CustomStyles.interRegular.copyWith(
            fontSize: 14,
            color: AppColors.c0D0140.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
