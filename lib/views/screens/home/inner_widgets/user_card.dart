
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../base/custom_dialog.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? viewProfileOnTap;
  final bool isDarkMode;
  final String name;
  final String image;
  final String labal;


  const UserCard({super.key, required this.isDarkMode, this.viewProfileOnTap, required this.name, required this.labal, required this.image});

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
                imageUrl: '$image',
                height: 60.h,
                width: 44.w,
                boxShape: BoxShape.circle),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'laval : $labal',
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


            GestureDetector(
              onTap: viewProfileOnTap,
              child: Container(
                width: 70.w,
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.backGroundDark
                        : AppColors.backGroundLight,
                    borderRadius: BorderRadius.circular(24.r)),
                padding: EdgeInsetsDirectional.all(10.r),
                child: Center(
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorGreen,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          contentPadding:
                          EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h),
                          content: CustomDialog(),
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(12.r),
                              side: BorderSide(
                                  width: 1.w,
                                  color: Colors
                                      .blueAccent)));
                    });
              },
              child: Container(
                  decoration:  BoxDecoration(
                      color: isDarkMode ? AppColors.backGroundDark : AppColors.backGroundLight,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: const Icon(Icons.call,
                        color: AppColors.textColorGreen),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
