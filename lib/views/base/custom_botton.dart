import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';



class CustomBotton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool loading;

  CustomBotton({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:loading?(){} :onpress,
      child: Container(
        width:width?? 345.w,
        height: height ?? 58.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(50.r),
            color: Colors.red
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            loading?  SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(color: Colors.white,),
            ):
            CustomText(
              text: title,
              fontsize: fontSize ?? 18.h,
              color: titlecolor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}