import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/views/base/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const CustomListTile({super.key,
    required this.title,
    required this.icon,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ListTile(
        leading: SvgPicture.asset(icon, color: Colors.white),
        title: Text('$title', textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.h)),

        onTap: onTap,
      ),
    );
  }
}
