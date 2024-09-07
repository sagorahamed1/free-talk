import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/utils/app_colors.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/base/call_invitation.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../services/firebase_services.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/Config.dart';
import '../../../utils/app_images.dart';
import '../../base/custom_text.dart';
import 'inner_widgets/drawer_section.dart';
import 'inner_widgets/user_card.dart';
import '../botton_nav_bar/botton_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final ThemeController themeController = Get.put(ThemeController());
  final bool isDarkMode = Get.isDarkMode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // bool _isLoaded = false;
  // BannerAd? _bannerAd;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadBanner();
  // }

  // void _loadBanner() {
  //   final adUnitId = Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/9214589741'
  //       : 'ca-app-pub-3940256099942544/9214589741';
  //
  //   _bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //
  //   _bannerAd?.load();
  // }

  // @override
  // void dispose() {
  //   _bannerAd?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    homeController.fetchAllUsers();
    print('=========================================== current userid : ${homeController.currectUser}');
    return Scaffold(
      backgroundColor: themeController.isDarkTheme.value
          ? const Color(0xff1d1b32)
          : const Color(0xffdae5ef),
      key: _scaffoldKey,
      drawer: DrawerSection(
        isDark: themeController.isDarkTheme.value,
        onTap: () {
          Navigator.of(context)
              .pop(); // Close the drawer when the close button is tapped
        },
      ),
      body: CallInvitation(
        userName: "${homeController.currectUser}",
        child: SafeArea(
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
                          color: themeController.isDarkTheme.value
                              ? AppColors.cardDark
                              : Colors.white70),
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
                                itemCount:
                                    homeController.availeGenderList.value.length,
                                itemBuilder: (context, index) {
                                  var data =
                                      homeController.availeGenderList[index];
                                  return GestureDetector(
                                    onTap: () {




                                      index == 0 ? const SizedBox() :

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 16.w, vertical: 10.h),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [


                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        Container(

                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            border: Border.all(color: Colors.blueAccent)
                                                          ),
                                                          child: Icon(Icons.close),
                                                        ),
                                                      ],
                                                    ),

                                                    SizedBox(height :16.h),


                                                    Text(
                                                     "Talk for 100 minutes to chat with a lovely girl. Keep talking, you're close! 😆😆",
                                                      // 'Congrats! You\'ve crossed 100 talk minutes! You\'re now eligible to connect with female participants. Keep chatting and enjoy!',
                                                      style: TextStyle(
                                                        fontSize: 16.h,
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context).colorScheme.onBackground,
                                                      ),
                                                    ),

                                                    SizedBox(height :24.h),

                                                  ],
                                                ),
                                                elevation: 12.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12.r),
                                                    side: BorderSide(
                                                        width: 1.w, color: Colors.blueAccent)));
                                          });





                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12.w),
                                      decoration: BoxDecoration(
                                          color: themeController.isDarkTheme.value
                                              ? AppColors.backGroundDark
                                              : AppColors.backGroundLight,
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
                                    ),
                                  );
                                },
                              ),
                            ),

                            // SizedBox(height: 16.h),

                            GestureDetector(
                              onTap : (){
                                FirebaseService().startGroupCall(context, '${homeController.currectUser}');
                                // startGroupCall(context, roomIdController.text, userNameController.text);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: themeController.isDarkTheme.value
                                        ? AppColors.backGroundDark
                                        : AppColors.backGroundLight,
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

                    Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeController.users.length,
                          itemBuilder: (context, index) {
                            var user = homeController.users[index];

                            if (homeController.currectUser != user.id){
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.profileScreen, parameters: {
                                      "screenType" : 'home'
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9.r),
                                        color: themeController.isDarkTheme.value
                                            ? AppColors.cardDark
                                            : Colors.white70),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: Row(
                                        children: [
                                          CustomNetworkImage(
                                              imageUrl: "${AppImages.man2}",
                                              height: 60.h,
                                              width: 44.w,
                                              boxShape: BoxShape.circle),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.name,
                                                style: TextStyle(
                                                  fontSize: 16.h,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                'laval : ${user.label}',
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
                                              decoration: BoxDecoration(
                                                  color: themeController
                                                      .isDarkTheme.value
                                                      ? AppColors.backGroundDark
                                                      : AppColors.backGroundLight,
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
                                ),
                              );
                            }else{
                               return const SizedBox.shrink();
                            }

                          }),
                    )

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
                  color: themeController.isDarkTheme.value
                      ? Colors.blue
                      : Colors.blueAccent,
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
