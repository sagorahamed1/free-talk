import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration gradientBoxDecorationCustom() {
  return  BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Color(0xFFd2dfca), // Light blue color, adjust as needed
      ],
    ),
  );
}