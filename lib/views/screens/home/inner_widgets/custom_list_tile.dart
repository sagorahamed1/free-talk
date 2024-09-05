import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/views/base/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isDark;
  final VoidCallback onTap;

  const CustomListTile({super.key,
    required this.title,
    required this.icon,
    required this.onTap, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ListTile(
        leading: SvgPicture.asset(icon, color: isDark ?   Colors.white : Colors.black),
        title: Text(
          '$title',
          style: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),


        onTap: onTap,
      ),
    );
  }
}
