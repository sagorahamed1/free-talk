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
      backgroundColor: isDarkMode ? const Color(0xff192D36) : const Color(0xff4f43b4),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xff192D36) : const Color(0xff4f43b4),
            ),
            child: Row(
              children: [
                CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaDL5AkQCUbh7QLz5mF5-TgDXHnMMYmvWiiw&s',
                  height: 50.h,
                  width: 50.w,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Sagor Ahamed',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.h,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode ? const Color(0xff192D36) : Colors.lightBlue.shade100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.r),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white70),
          CustomListTile(
            title: 'Change Password',
            icon: AppIcons.lock,
            onTap: () {},
          ),
          CustomListTile(
            title: 'Bangladesh',
            icon: AppIcons.flag,
            onTap: () {},
          ),
          CustomListTile(
            title: 'Privacy Policy',
            icon: AppIcons.privacy,
            onTap: () {
              // Uncomment to navigate
              // Get.toNamed(AppRoutes.settingScreen);
            },
          ),
          CustomListTile(
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
              title: themeController.isDarkTheme.value ? 'Dark Theme' : 'Light Theme',
              icon: themeController.isDarkTheme.value ? AppIcons.dark : AppIcons.lightTheme,
              onTap: () {
                themeController.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
