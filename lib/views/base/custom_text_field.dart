import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/theme_manager.dart';
import '../../utils/app_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscure;
  final Color? filColor;
  final Color? borderColor;
  final Color? hintextColor;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final int? maxLine;
  final double? hintextSize;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final bool isPassword;
  final bool? isEmail;
  final bool? readOnly;
  final bool isDark;
  final double? borderRadio;

  const CustomTextField(
      {super.key,
      this.contentPaddingHorizontal,
      this.contentPaddingVertical,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLine,
      this.validator,
      this.hintextColor,
      this.borderColor,
      this.isEmail,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.isObscureText = false,
      this.obscure = '*',
      this.filColor,
      this.hintextSize,
      this.labelText,
      this.isPassword = false,
      this.readOnly = false,
      this.borderRadio, required this.isDark,});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly!,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscure!,
      maxLines: widget.maxLine ?? 1,
      // validator: widget.validator,
      validator: widget.validator ??
          (value) {
            if (widget.isEmail == null) {
              if (value!.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (widget.isPassword) {
                bool data = AppConstants.validatePassword(value);
                if (value.isEmpty) {
                  return "Please enter ${widget.hintText!.toLowerCase()}";
                } else if (data) {
                  return "Insecure password detected.";
                }
              }
            } else {
              bool data = AppConstants.emailValidate.hasMatch(value!);
              if (value.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (!data) {
                return "Please check your email!";
              }
            }
            return null;
          },

      cursorColor: widget.isDark ? Colors.white : Colors.black,
      obscureText: widget.isPassword ? obscureText : false,
      style: TextStyle(
          color:  widget.isDark ? Colors.white : Colors.black,
          fontSize: widget.hintextSize ?? 12.h),

      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: widget.contentPaddingHorizontal ?? 20.w,
              vertical: widget.contentPaddingVertical ?? 11.h),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: toggle,
                  child: _suffixIcon(obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                )
              : widget.suffixIcon,
          prefixIconConstraints:
              BoxConstraints(minHeight: 24.w, minWidth: 24.w),
          labelText: widget.labelText,
          hintText: widget.hintText,
          // hintStyle: TextStyle(
          //     color: widget.hintextColor ?? Colors.black,
          //     fontSize: widget.hintextSize ?? 12.h,
          //     fontWeight: FontWeight.w400),
          focusedBorder: focusedBorder(),
          errorBorder: focusedBorder(),
          border: focusedBorder(),
          enabledBorder: enabledBorder()),
    );
  }

  _suffixIcon(IconData icon) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(icon, color: widget.isDark ? Colors.white24 : Colors.black87));
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide: BorderSide(color:  widget.isDark ? Colors.white24 : Colors.black87),
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide: BorderSide(color:  widget.isDark ? Colors.white24 : Colors.black87),
    );
  }
}
