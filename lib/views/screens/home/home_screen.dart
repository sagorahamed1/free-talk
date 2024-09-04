import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/utils/app_colors.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import 'inner_widgets/drawer_section.dart';
import 'inner_widgets/user_card.dart';
import '../botton_nav_bar/botton_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoaded = false;
  BannerAd? _bannerAd;
  final HomeController homeController = Get.put(HomeController());
  final bool isDarkMode = Get.isDarkMode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    final adUnitId = Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/9214589741'
        : 'ca-app-pub-3940256099942544/9214589741';

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
      key: _scaffoldKey,
      endDrawer: DrawerSection(
        isDark: isDarkMode,
        onTap: () {
          Navigator.of(context)
              .pop(); // Close the drawer when the close button is tapped
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello Vani,',
                            style: TextStyle(
                              fontSize: 16.h,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            'Welcome!!',
                            style: TextStyle(
                              fontSize: 20.h,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),

                      // when check on this bottom drawer is work
                      GestureDetector(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Icon(Icons.menu))
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: isDarkMode ? AppColors.cardDark : Colors.white70),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.availeGenderList.value.length,
                              itemBuilder: (context, index) {
                                var data = homeController.availeGenderList[index];
                                return Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration:  BoxDecoration(
                                      color: isDarkMode ? AppColors.backGroundDark : AppColors.backGroundLight,
                                      shape: BoxShape.circle),
                                  padding: EdgeInsetsDirectional.all(20.r),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset("${data['icon']}",
                                            height: 32.h,
                                            width: 32.w,
                                            fit: BoxFit.cover,
                                            color: homeController
                                                        .availeGenderSelectedIndex ==
                                                    index
                                                ? AppColors.textColorGreen
                                                : Colors.white),
                                        SizedBox(height: 10.h),
                                        Text(
                                          '${data['title']}',
                                          style: TextStyle(
                                              fontSize: 10.h,
                                              color: homeController
                                                          .availeGenderSelectedIndex ==
                                                      index
                                                  ? AppColors.textColorGreen
                                                  : Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // SizedBox(height: 16.h),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:  isDarkMode ? AppColors.backGroundDark : AppColors.backGroundLight,
                                borderRadius: BorderRadius.circular(8.r)),
                            padding: EdgeInsetsDirectional.all(12.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.call,
                                    color: AppColors.textColorGreen),
                                SizedBox(width: 10.w),
                                Text(
                                  'call your expert person',
                                  style: TextStyle(
                                    fontSize: 14.h,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColorGreen,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // _buildBalanceCard(),
                  _seeAll('Expert', 'See All', () {
                    Get.toNamed(AppRoutes.allUserScreen);
                  }),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                      return  Padding(
                        padding:  EdgeInsets.only(bottom: 10.h),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.r),
                                color: isDarkMode
                                    ? AppColors.cardDark
                                    : Colors.white70),
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                children: [
                                  CustomNetworkImage(
                                      imageUrl: '',
                                      height: 60.h,
                                      width: 44.w,
                                      boxShape: BoxShape.circle),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sagor Ahamed',
                                        style: TextStyle(
                                          fontSize: 16.h,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        'laval : Expert',
                                        style: TextStyle(
                                          fontSize: 12.h,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                      decoration:  BoxDecoration(
                                          color: isDarkMode ? AppColors.backGroundDark : AppColors.backGroundLight,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding: EdgeInsets.all(6.r),
                                        child: const Icon(Icons.call,
                                            color: AppColors.textColorGreen),
                                      ))
                                ],
                              ),
                            ),
                          ),
                      );
                      })

                  // Obx(() {
                  //   return SizedBox(
                  //     height: 230.h,
                  //     child: ListView.builder(
                  //       itemCount: 3,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         var user = homeController.users[index];
                  //         if (homeController.currectUser != user.id) {
                  //           return Padding(
                  //             padding: EdgeInsets.only(
                  //               right: index != homeController.users.length - 1
                  //                   ? 16.w
                  //                   : 0,
                  //             ),
                  //             child: UserCard(
                  //               name: user.name,
                  //               aboutMe: user.aboutMe,
                  //               totalCall: user.totalCall,
                  //               totalMinute: user.totalTalkTime,
                  //               totalReviews: user.totalReviews,
                  //               viewProfileOnTap: () {
                  //                 Get.toNamed(AppRoutes.profileScreen);
                  //               },
                  //               isDark: isDarkMode,
                  //             ),
                  //           );
                  //         } else {
                  //           return const SizedBox.shrink();
                  //         }
                  //       },
                  //     ),
                  //   );
                  // }),
                ],
              ),
            ),
            BottomMenu(0),
          ],
        ),
      ),
    );
  }

  Widget _seeAll(String leftText, String seeAllText, VoidCallback onTap) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                seeAllText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.blue : Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

///ads
///                if (_isLoaded)
//                   Container(
//                     width: 350.w,
//                     height: 100,
//                     child: AdWidget(ad: _bannerAd!),
//                   ),
//                 SizedBox(height: 12.h),
