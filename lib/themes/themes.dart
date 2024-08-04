import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: CupertinoColors.secondaryLabel,

    ///====Icon Theme Dark=====>
    iconTheme: IconThemeData(
        color: Colors.white,
        size: 24.h
    ),
  ///===Text Theme Dark====>
  textTheme: TextTheme(
    titleSmall: TextStyle(color: Colors.white, fontSize: 14.h),
    titleMedium: TextStyle(color: Colors.white, fontSize: 16.h),
    titleLarge: TextStyle(color: Colors.white, fontSize: 21.h),
  )
);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.secondaryLabel,

    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24.h
    ),

    ///===Text Theme====>
    textTheme: TextTheme(
      titleSmall: TextStyle(color: Colors.black, fontSize: 14.h),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16.h),
      titleLarge: TextStyle(color: Colors.black, fontSize: 21.h),
    )

);