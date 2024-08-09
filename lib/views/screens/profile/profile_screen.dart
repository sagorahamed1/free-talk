import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/controllers/profile_controller.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../services/theme_manager.dart';
import '../../../utils/app_colors.dart';
import '../botton_nav_bar/botton_nav_bar.dart';
import 'inner_widgets/custom_list_tile_svg_pic.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ThemeController themeController = Get.put(ThemeController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.getProfileData();
    return Scaffold(
      bottomNavigationBar: const BottomMenu(1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(() {
            print("====profile Data : ${profileController.userData.value}");
            return  Column(
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

                Text(
                  profileController.userData.value.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.h,
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.black),
                ),
                SizedBox(height: 30.h),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildStatColumn('${profileController.userData.value.totalTalkTime}', 'Minute', Icon(Icons.call, size: 16.r),),
                    _buildStatColumn('${profileController.userData.value.totalCall}', 'Call', Icon(Icons.call, size: 16.r),),
                    _buildStatColumn('${profileController.userData.value.totalReviews}', 'Reviews',Icon(Icons.star, size: 16.r),),
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
                            fontWeight: FontWeight.w700,
                            fontSize: 22.h,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black),
                      ),

                      SizedBox(height: 13.h),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Email',
                        subTitle: '${profileController.userData.value.email}',
                        icon: AppIcons.profile,
                      ),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Country',
                        subTitle: '${profileController.userData.value.country}',
                        icon: AppIcons.profile,
                      ),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Gender',
                        subTitle: '${profileController.userData.value.gender}',
                        icon: AppIcons.profile,
                      ),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Languages',
                        subTitle: 'Bangle, English',
                        icon: AppIcons.profile,
                      ),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Label',
                        subTitle: '${profileController.userData.value.label}',
                        icon: AppIcons.profile,
                      ),
                      CustomListTileSvgPic(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {},
                        title: 'Coin',
                        subTitle: '${profileController.userData.value.coin}',
                        icon: AppIcons.profile,
                      ),



                      SizedBox(height: 20.h),
                      Text(
                        "Top Reviews",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22.h,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black),
                      ),
                      SizedBox(height: 13.h),


                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 14.h),
                            child:  TopReviewsCardForProfile(
                              isDark: themeController.isDarkTheme.value,
                              image: '',
                              description: "You are the Great Speaker. Today i become amazing experience talk to you. Thank you Brother",
                              rathing: "4.5",
                              reviewName: "Mahim Rana",
                              timeAgo: "1 month ago",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }

          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label, Icon icon) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
       color:  themeController.isDarkTheme.value
            ? const Color(0xff192D36)
            : Colors.lightBlue.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(text: count, fontsize: 16),
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                CustomText(text: label, left: 6.w, right: 6.w,),
              ],
            )
          ],
        ),
      ),
    );
  }
}





class TopReviewsCardForProfile extends StatelessWidget {
  final String? image;
  final String? description;
  final String? timeAgo;
  final String? rathing;
  final String? reviewName;
  final bool isDark;

  const TopReviewsCardForProfile(
      {super.key,
        this.image,
        this.description,
        this.timeAgo,
        this.rathing,
        this.reviewName, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isDark
            ? const Color(0xff192D36)
            : Colors.lightBlue.withOpacity(0.15),
      ),
      child: Padding(
        padding:  EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///========================Image and Name======================>
                Row(
                  children: [
                    Container(
                        height: 48.h,
                        width: 48.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: CustomNetworkImage(
                         imageUrl:  '$image',
                          height: 90.h,
                          width: 90.w,
                          boxShape: BoxShape.circle,
                        )),
                    CustomText(
                      text: "$reviewName",
                      fontsize: 16,
                      fontWeight: FontWeight.w600,
                      left: 16.w,
                    )
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: isDark? AppColors.scaffoldBg : Colors.black54)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    child: Row(
                      children: [
                         Icon(Icons.star, size: 16.r),
                        CustomText(
                            text: "  $rathing",
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "$description",
              maxline: 10,
              bottom: 8.h,
              textAlign: TextAlign.start,
            ),
            CustomText(
              text: '$timeAgo',
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

