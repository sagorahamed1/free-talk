import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration gradientBoxDecorationCustom(Color top, bottom) {
  return  BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: Colors.grey),
    gradient:  LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        top,
        bottom, // Light blue color, adjust as needed
      ],
    ),
  );
}