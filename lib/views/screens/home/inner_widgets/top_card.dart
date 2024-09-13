import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/theme_manager.dart';
import '../../../base/custom_text.dart';
import '../../../base/dialog.dart';

class TopCard extends StatefulWidget {
  const TopCard({super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  final ThemeController themeController = Get.find<ThemeController>();
  String selectedButton = 'any';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: themeController.isDarkTheme.value
              ? const Color(0xff252c3b)
              : Colors.lightBlue.shade100,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),

                // Call Button
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.reviewScreen);
                  },
                  child: Container(
                    width: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: themeController.isDarkTheme.value
                          ? const Color(0xff4f43b4)
                          : Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 12.w),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        CustomText(
                          text: "Call Now",
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                // Gender Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ['Any', 'Female', 'Male'].map((name) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (name == 'Any') {
                            selectedButton = name;
                          } else {
                            showLogoutDialog(context);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 550),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: selectedButton == name
                              ? themeController.isDarkTheme.value
                              ? const Color(0xff4f43b4)
                              : Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: selectedButton == name
                                  ? themeController.isDarkTheme.value
                                  ? Colors.deepPurpleAccent
                                  : Colors.blueAccent
                                  : Colors.grey,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 18.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
