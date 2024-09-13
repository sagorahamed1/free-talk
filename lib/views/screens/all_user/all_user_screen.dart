import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_images.dart';
import '../home/inner_widgets/user_card.dart';

class AllUserScreen extends StatelessWidget {
   AllUserScreen({super.key});

  ThemeController themeController = Get.find<ThemeController>();
   final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    homeController.fetchAllUsers();
    return Scaffold(
      backgroundColor: themeController.isDarkTheme.value ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
      appBar: AppBar(
        backgroundColor: themeController.isDarkTheme.value ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
        centerTitle: true,
        title: Text(
        "Users",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.h,
            color: themeController.isDarkTheme.value
                ? Colors.white
                : Colors.black),
      ),),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Expanded(
            child: Obx(()=>
               ListView.builder(
                itemCount: homeController.users.length,
                itemBuilder: (context, index) {
                  var user = homeController.users[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 18.h : 0,
                        bottom: 16.h),
                    child: UserCard(
                      image:  "${AppImages.man2}",
                      labal: '${user.label}',
                      name: user.name,
                      // viewProfileOnTap: () {
                      //   Get.toNamed(AppRoutes.profileScreen);
                      // },
                      viewProfileOnTap: () {
                        Get.toNamed(AppRoutes.profileScreen,
                            parameters: {
                              "screenType": 'home',
                              "id": user.id,
                            });
                      },

                      isDarkMode: themeController
                          .isDarkTheme.value,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
    );
  }
}
