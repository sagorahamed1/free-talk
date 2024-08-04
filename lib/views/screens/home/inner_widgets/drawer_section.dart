import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/theme_manager.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';
import 'custom_list_tile.dart';

class drawerSection extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;

  const drawerSection({super.key, required this.onTap, required this.isDark});

  @override
  State<drawerSection> createState() => _drawerSectionState();
}

class _drawerSectionState extends State<drawerSection> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 270.w,
      color: widget.isDark ? const Color(0xff0D222B) : Colors.white,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: 'll',
                height: 50.h,
                width: 50.w,
              ),
            ),
            title: CustomText(text: 'Sagor Ahamed', fontsize: 16,textAlign: TextAlign.start),
            subtitle: CustomText(
              textAlign: TextAlign.start,
                text: "software developer",
                color: widget.isDark ? Colors.white10 : Colors.black54),
            trailing: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isDark ? const Color(0xff192D36) : Colors.lightBlue.shade100),
                    child: Padding(
                      padding:  EdgeInsets.all(5.r),
                      child: const Icon(Icons.close),
                    ))),
          ),

          const Divider(color: Colors.black45),

          CustomListTile(
            title: 'Change Password',
            icon: const Icon(Icons.confirmation_num_sharp),
            onTap: () {},
          ),

          CustomListTile(
            title: 'Setting',
            icon: const Icon(Icons.settings),
            onTap: () {},
          ),

          CustomListTile(
            title: 'Bangladesh',
            icon: const Icon(Icons.co2),
            onTap: () {},
          ),

          ///===========theme change====>
          Obx(
            () => CustomListTile(
              title: themeController.isDarkTheme.value
                  ? 'Dark Theme'
                  : 'Light Theme',
              icon: themeController.isDarkTheme.value
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.light_mode),
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
