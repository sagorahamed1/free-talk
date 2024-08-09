import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../home/inner_widgets/user_card.dart';

class AllUserScreen extends StatelessWidget {
   AllUserScreen({super.key});

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
        "Users",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22.h,
            color: themeController.isDarkTheme.value
                ? Colors.white
                : Colors.black),
      ),),
        body: Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 18.h : 0,
                    bottom: 16.h),
                child: UserCard(
                  totalReviews: '',
                  totalMinute: '',
                  totalCall: '',
                  aboutMe: '',
                  name: '',
                  viewProfileOnTap: () {
                    Get.toNamed(AppRoutes.profileScreen);
                  },
                  isDark: themeController
                      .isDarkTheme.value,
                ),
              );
            },
          ),
        ),
    );
  }
}
