import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:get/get.dart';

import '../../../../services/theme_manager.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';
import 'custom_list_tile.dart';

class DrawerSection extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;

  const DrawerSection({super.key, required this.onTap, required this.isDark});

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
                    'Sagor Ahamed dkdkk',
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
            onTap: () {},
          ),

          CustomListTile(
            isDark: isDarkMode,
            title: 'Privacy Policy',
            icon: AppIcons.privacy,
            onTap: () {
              // Uncomment to navigate
              // Get.toNamed(AppRoutes.settingScreen);
            },
          ),
          CustomListTile(
            isDark: isDarkMode,
            title: 'Terms & Conditions',
            icon: AppIcons.termConditions,
            onTap: () {
              // Uncomment to navigate
              // Get.toNamed(AppRoutes.settingScreen);
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
              Get.toNamed(AppRoutes.logInScreen);
            },
          ),
        ],
      ),
    );
  }
}
