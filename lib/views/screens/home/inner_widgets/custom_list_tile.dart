
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const CustomListTile(
      {super.key,
        required this.title,
        required this.icon,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ListTile(
        leading: icon,
        title: CustomText(text: title, textAlign: TextAlign.start,),
        onTap: onTap,
      ),
    );
  }
}
