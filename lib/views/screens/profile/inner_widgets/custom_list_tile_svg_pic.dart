import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk/utils/app_icons.dart';

import '../../../../utils/app_colors.dart';
import '../../../base/custom_text.dart';

class CustomListTileSvgPic extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final bool isDark;
  final VoidCallback onTap;

  const CustomListTileSvgPic(
      {super.key,
        required this.title,
        required this.icon,
        required this.onTap,
        required this.subTitle, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
            color: isDark
                ? AppColors.cardDark
                : Colors.white70
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              Container(
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xff192D36)
                      : Colors.lightBlue.withOpacity(0.15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(icon, color: isDark ? Colors.white : Colors.black),
                ),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.h,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),

                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 15.h,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),

                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
