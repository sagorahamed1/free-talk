import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/controllers/profile_controller.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/utils/app_images.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../helpers/prefs_helper.dart';
import '../../../models/user_model.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../botton_nav_bar/botton_nav_bar.dart';
import 'inner_widgets/custom_list_tile_svg_pic.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ThemeController themeController = Get.put(ThemeController());
  ProfileController profileController = Get.put(ProfileController());


  String? currectUser;


  @override
  void initState() {
    super.initState();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    String? userId = await PrefsHelper.getString(AppConstants.currentUser);

    setState(() {
      currectUser = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    // profileController.getProfileData("");
    if(Get.parameters["screenType"] ==  'home'){
      profileController.getProfileData("${Get.parameters['id']}");
    }else{
      profileController.getProfileData("$currectUser");
    }

    profileController.reviewData("receverId");//demo
    print("===========================================dddd====${Get.parameters['id']}");
    return Scaffold(
      backgroundColor: themeController.isDarkTheme.value ? const Color(0xff1d1b32) : const Color(0xffdae5ef),

      appBar: Get.parameters['screenType'] == 'home' ? AppBar(backgroundColor: themeController.isDarkTheme.value ? const Color(0xff1d1b32) : const Color(0xffdae5ef)) : null,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaDL5AkQCUbh7QLz5mF5-TgDXHnMMYmvWiiw&s',
                        height: 110.h,
                        width: 110.w,
                        boxShape: BoxShape.circle,
                      ),
                    ),

                    SizedBox(height: 9.h),


                    Text(
                      profileController.userData.value.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.h,
                          color: themeController.isDarkTheme.value
                              ? Colors.white
                              : Colors.black),
                    ),

                    SizedBox(height: 15.h),

                    // GestureDetector(
                    //   onTap: (){
                    //     Get.toNamed(AppRoutes.editProfileScreen);
                    //   },
                    //   child: Container(
                    //     width: 130.w,
                    //     height: 40.h,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16.r),
                    //       color: Colors.lightBlue
                    //     ),
                    //     child: Center(child: CustomText(text: "Edit Profile",)),
                    //   ),
                    // ),
                    //
                    //
                    // SizedBox(height: 30.h),
                    //

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStatColumn('${profileController.userData.value.totalTalkTime}', 'Minute', Icon(Icons.call, size: 16.r), context),
                        _buildStatColumn('${profileController.userData.value.totalCall}', 'Call', Icon(Icons.call, size: 16.r),context),
                        _buildStatColumn('${profileController.userData.value.totalReviews}', 'Reviews',Icon(Icons.star, size: 16.r),context),
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
                            'Information',
                            style: TextStyle(
                              fontSize: 20.h,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),


                          SizedBox(height: 13.h),
                          CustomListTileSvgPic(
                            isDark: themeController.isDarkTheme.value,
                            onTap: () {},
                            title: 'Email',
                            subTitle: '${profileController.userData.value.email}',
                            icon: AppIcons.email,
                          ),
                          CustomListTileSvgPic(
                            isDark: themeController.isDarkTheme.value,
                            onTap: () {},
                            title: 'Country',
                            subTitle: '${profileController.userData.value.country}',
                            icon: AppIcons.flag,
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
                            subTitle: 'English',
                            icon: AppIcons.language,
                          ),
                          CustomListTileSvgPic(
                            isDark: themeController.isDarkTheme.value,
                            onTap: () {},
                            title: 'Label',
                            subTitle: '${profileController.userData.value.label}',
                            icon: AppIcons.label,
                          ),
                          CustomListTileSvgPic(
                            isDark: themeController.isDarkTheme.value,
                            onTap: () {},
                            title: 'Coin',
                            subTitle: '${profileController.userData.value.coin}',
                            icon: AppIcons.coin,
                          ),



                          SizedBox(height: 20.h),
                          Text(
                            'Top Reviews',
                            style: TextStyle(
                              fontSize: 20.h,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),

                          SizedBox(height: 13.h),

                          // ListView.builder(
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   itemCount: 5,
                          //   itemBuilder: (context, index) {
                          //     return Padding(
                          //       padding: EdgeInsets.only(bottom: 14.h),
                          //       child:  TopReviewsCardForProfile(
                          //         isDark: themeController.isDarkTheme.value,
                          //         image: '${AppImages.man2}',
                          //         description: "You are the Great Speaker. Today i become amazing experience talk to you. Thank you Brother",
                          //         rathing: "4.5",
                          //         reviewName: "Mahim Rana",
                          //         timeAgo: "1 month ago",
                          //       ),
                          //     );
                          //   },
                          // ),



                          Obx(() {
                            if (profileController.reviewsLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (profileController.reviews.isEmpty) {
                              return Center(child: Text("No reviews available."));
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profileController. reviews.length,
                              itemBuilder: (context, index) {
                                final review = profileController. reviews[index];
                                return Padding(
                                  padding:  EdgeInsets.only(bottom: 16.h),
                                  child: TopReviewsCardForProfile(
                                              isDark: themeController.isDarkTheme.value,
                                              image: '${AppImages.man2}',
                                              description: "${review.description}",
                                              rathing: "${review.rating}",
                                              reviewName: "${review.reviewName}",
                                              timeAgo: "${review.rating} time",
                                            ),
                                );
                              },
                            );
                          }),


                          SizedBox(height: 100.h)



                        ],
                      ),
                    )
                  ],
                );
              }

              ),
            ),
          ),


         Get.parameters['screenType'] == 'home' ? const SizedBox() :  const Positioned(child: BottomMenu(1))
        ],
      ),
    );
  }

  Widget _buildStatColumn(String? count, String label, Icon icon, context) {
    return Container(
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
       color:  themeController.isDarkTheme.value
           ? AppColors.cardDark
          : Colors.white70
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              count ?? '0',
              style: TextStyle(
                fontSize: 15.h,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
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
              ? AppColors.cardDark
              : Colors.white70
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
                         imageUrl:'$image',
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

