
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? viewProfileOnTap;
  final bool isDarkMode;
  final String name;
  final String aboutMe;
  final String totalMinute;
  final String totalCall;
  final String totalReviews;

  const UserCard({super.key, required this.isDarkMode, this.viewProfileOnTap, required this.name, required this.aboutMe, required this.totalMinute, required this.totalCall, required this.totalReviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: isDarkMode
              ? AppColors.cardDark
              : Colors.white70),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            CustomNetworkImage(
                imageUrl: '',
                height: 60.h,
                width: 44.w,
                boxShape: BoxShape.circle),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sagor Ahamed',
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'laval : Expert',
                  style: TextStyle(
                    fontSize: 12.h,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
                decoration:  BoxDecoration(
                    color: isDarkMode ? AppColors.backGroundDark : AppColors.backGroundLight,
                    shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: const Icon(Icons.call,
                      color: AppColors.textColorGreen),
                ))
          ],
        ),
      ),
    );
  }
}
