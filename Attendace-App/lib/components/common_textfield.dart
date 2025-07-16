import 'package:attendance_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonFieldComponent extends StatelessWidget {
  const CommonFieldComponent({
    super.key,
    this.prefixIcon,
    this.controller,
    this.hintText,
    this.hintColor,
    this.maxLines,
    this.minLines,
    this.enable = true,
    this.obscureText = false,
    this.keyboardType,
  });
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final bool enable;
  final bool? obscureText;
  final Color? hintColor;
  // final int? maxLength;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomeColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xffDAE1E1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextField(
          cursorColor: CustomeColors.primary,
          enabled: enable,
          controller: controller,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          obscureText: obscureText!,
          obscuringCharacter: "*",
          // maxLength: maxLength,
          decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: prefixIcon,
              hintText: hintText,
              hintStyle:
                  TextStyle(color: hintColor ?? const Color(0xffDAE1E1))),
        ),
      ),
    );
  }
}
