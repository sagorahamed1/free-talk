import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/utils/app_strings.dart';
import 'package:get/get.dart';

import '../../../../services/theme_manager.dart';
import '../../../../utils/app_colors.dart';
import '../../../base/CustomButton.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';
import 'custom_list_tile.dart';

class DrawerSection extends StatefulWidget {
  final bool isDark;
  final String name;
  final VoidCallback onTap;

  const DrawerSection({super.key, required this.onTap, required this.isDark, required this.name});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeController.isDarkTheme.value;

    return Drawer(
      backgroundColor:
      isDarkMode ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color:
          isDarkMode ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
            ),
            child: Row(
              children: [
                CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaDL5AkQCUbh7QLz5mF5-TgDXHnMMYmvWiiw&s',
                  height: 50.h,
                  width: 50.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child:  Text(
                    '${widget.name}',
                    style: TextStyle(
                      fontSize: 20.h,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),

          CustomListTile(
            isDark: isDarkMode,
            title: 'Change Password',
            icon: AppIcons.lock,
            onTap: () {
              Get.toNamed(AppRoutes.changePasswordScreen);
            },
          ),

          CustomListTile(
            isDark: isDarkMode,
            title: 'Privacy Policy',
            icon: AppIcons.privacy,
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicyAllScreen, parameters: {
                'screenType' : AppStrings.privacyPolicy
              });
            },
          ),
          CustomListTile(
            isDark: isDarkMode,
            title: 'Terms & Conditions',
            icon: AppIcons.termConditions,
            onTap: () {
              Get.toNamed(AppRoutes.privacyPolicyAllScreen, parameters: {
                'screenType' : AppStrings.termsConditions
              });
            },
          ),
          // Theme toggle
          Obx(
                () => CustomListTile(
                  isDark: isDarkMode,
              title: themeController.isDarkTheme.value ? 'Dark Theme' : 'Light Theme',
              icon: themeController.isDarkTheme.value ? AppIcons.dark : AppIcons.lightTheme,
              onTap: () {
                themeController.toggleTheme();
              },
            ),
          ),


          SizedBox(height: 150.h),
           Divider(height: 0.1.h, color: Colors.grey),
          CustomListTile(
            isDark: isDarkMode,
            title: 'Log Out',
            icon: AppIcons.logOut,
            onTap: () {



              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 26.h),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: "Are You Sure To Logout Your \n Profile",
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w600,
                              maxline: 2,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 120.w,
                                    height: 40.h,
                                    child: CustomButton(
                                      color: Colors.transparent,
                                      onTap: () {
                                        Get.back();
                                      }, text: 'No',
                                    )),
                                SizedBox(
                                    width: 120.w,
                                    height: 40.h,
                                    child: CustomButton(
                                      color: Colors.blueAccent,
                                      text: "yes",
                                      onTap: (){
                                         Get.toNamed(AppRoutes.logInScreen);
                                      },
                                    )),
                              ],
                            )
                          ],
                        ),
                        elevation: 12.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                                width: 1.w, color: Colors.blueAccent)));
                  });






            },
          ),
        ],
      ),
    );
  }
}



