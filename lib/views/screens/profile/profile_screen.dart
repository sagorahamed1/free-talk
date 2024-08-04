import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../services/theme_manager.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),

            ///======Profile image====>
            Align(
              alignment: Alignment.topCenter,
              child: CustomNetworkImage(
                imageUrl: 'imageUrl',
                height: 110.h,
                width: 110.w,
                boxShape: BoxShape.circle,
              ),
            ),

            CustomText(text: 'Sagor Ahamed', fontsize: 16, bottom: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildStatColumn('15K', 'Minute'),
                _buildStatColumn('82', 'Call'),
                _buildStatColumn('20', 'Reviews'),
              ],
            ),

            SizedBox(height: 20.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Information",
                    style: TextStyle(
                        fontSize: 22.h,
                        color: themeController.isDarkTheme.value
                            ? Colors.white
                            : Colors.black),
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Email',
                    subTitle: 'sagorahamed@gmail.com',
                    icon: AppIcons.profile,
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Country',
                    subTitle: 'Bangladesh',
                    icon: AppIcons.profile,
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Gender',
                    subTitle: 'Male',
                    icon: AppIcons.profile,
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Languages',
                    subTitle: 'Bangle, English',
                    icon: AppIcons.profile,
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Label',
                    subTitle: 'Basic',
                    icon: AppIcons.profile,
                  ),
                  CustomListTileSvgPic(
                    onTap: () {},
                    title: 'Coin',
                    subTitle: '10000',
                    icon: AppIcons.profile,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(text: count, fontsize: 16),
        CustomText(text: label)
      ],
    );
  }
}

class CustomListTileSvgPic extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final VoidCallback onTap;

  const CustomListTileSvgPic(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: ListTile(
        leading: SvgPicture.asset(icon),
        title: CustomText(text: title, textAlign: TextAlign.start),
        subtitle: CustomText(
          text: subTitle,
          textAlign: TextAlign.start,
        ),
        onTap: onTap,
      ),
    );
  }
}
