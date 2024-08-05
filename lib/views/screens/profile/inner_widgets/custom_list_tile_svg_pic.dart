import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk/utils/app_icons.dart';

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
              ? const Color(0xff192D36)
              : Colors.lightBlue.withOpacity(0.15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xff192D36)
                      : Colors.lightBlue.withOpacity(0.15),
                ),
                child: SvgPicture.asset(AppIcons.profile),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: title, textAlign: TextAlign.start, fontsize: 20, left: 12.w),
                  CustomText(
                    text: subTitle,
                    textAlign: TextAlign.start,
                    left: 12.w,
                  ),
                ],
              )

              // ListTile(
              //   dense: true,
              //   contentPadding: EdgeInsets.zero,
              //   leading: SvgPicture.asset(icon),
              //   title: CustomText(text: title, textAlign: TextAlign.start, fontsize: 16),
              //   subtitle: CustomText(
              //     text: subTitle,
              //     textAlign: TextAlign.start,
              //   ),
              //   onTap: onTap,
              // ),
            ],
          ),
        )
      ),
    );
  }
}
