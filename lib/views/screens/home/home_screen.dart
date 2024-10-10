
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/utils/app_colors.dart';
import 'package:free_talk/views/base/call_invitation.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../helpers/toast_message_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../services/firebase_services.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../base/custom_dialog.dart';
import 'inner_widgets/drawer_section.dart';
import '../botton_nav_bar/botton_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final bool isDarkMode = Get.isDarkMode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? currectUser;
  String? userImage;
  RxString currectName = ''.obs;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    String? userId = await PrefsHelper.getString(AppConstants.currentUser);
    String? userName = await PrefsHelper.getString(AppConstants.name);
    String? image = await PrefsHelper.getString(AppConstants.image);
    setState(() {
      currectUser = userId;
      currectName.value = userName;
      userImage = image;
    });
  }

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
    print('=========================================== current userid : $currectUser');
    return Scaffold(
      backgroundColor: themeController.isDarkTheme.value
          ? const Color(0xff1d1b32)
          : const Color(0xffdae5ef),
      key: _scaffoldKey,
      drawer: DrawerSection(
        isDark: themeController.isDarkTheme.value,
        name: currectName.value,
        image: "$userImage",
        onTap: () {
          Navigator.of(context)
              .pop(); // Close the drawer when the close button is tapped
        },
      ),
      body: CallInvitation(
        userId: "$currectUser",
        userName: "$currectName",
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
                              'Hello $currectName,',
                              style: TextStyle(
                                fontSize: 16.h,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 20.h,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                        padding:  EdgeInsets.all(16.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController
                                    .availeGenderList.length,
                                itemBuilder: (context, index) {
                                  var data =
                                      homeController.availeGenderList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      index == 0
                                          ? const SizedBox()
                                          : showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.w,
                                                            vertical: 10.h),
                                                    content: const CustomDialog(),
                                                    elevation: 12.0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        side: BorderSide(
                                                            width: 1.w,
                                                            color: Colors
                                                                .blueAccent)));
                                              });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      decoration: BoxDecoration(
                                          color:
                                              themeController.isDarkTheme.value
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

                            Obx(
                              () => GestureDetector(
                                // onTap: () {
                                //    homeController.startTimer();
                                //   if (homeController.isCalling.value) {
                                //       FirebaseService().startGroupCall(context, '$currectUser', currectName.value);
                                //   }
                                // },

                                onTap: () {
                                  if (!homeController.isCalling.value) {
                                    homeController.startTimer();
                                    if (homeController.isCalling.value) {
                                      FirebaseService().startGroupCall(context, '$currectUser', currectName.value, "$userImage");
                                    }
                                  } else {
                                    print("You can't make a call within 20 seconds of the last call.");
                                    ToastMessageHelper.showToastMessage("Please wait 20 seconds before making another call.");
                                  }
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
                                        homeController.buttonLabel.value,
                                        style: TextStyle(
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textColorGreen,
                                        ),
                                      ),
                                    ],
                                  ),
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
                          itemCount: min(homeController.users.length, 4),
                          itemBuilder: (context, index) {
                            var user = homeController.users[index];

                            if (currectUser != user.id) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(9.r),
                                      color: themeController.isDarkTheme.value
                                          ? AppColors.cardDark
                                          : Colors.white70),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.r),
                                    child: Row(
                                      children: [
                                        CustomNetworkImage(
                                            imageUrl: user.image,
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


                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.profileScreen,
                                                parameters: {
                                                  "screenType": 'home',
                                                  "id": user.id,
                                                });
                                          },
                                          child: Container(
                                            width: 70.w,
                                            decoration: BoxDecoration(
                                                color: themeController.isDarkTheme.value
                                                    ? AppColors.backGroundDark
                                                    : AppColors.backGroundLight,
                                                borderRadius: BorderRadius.circular(24.r)),
                                            padding: EdgeInsetsDirectional.all(10.r),
                                            child: Center(
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                  fontSize: 14.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textColorGreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 10.w),

                                        GestureDetector(
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16.w,
                                                          vertical: 10.h),
                                                      content: const CustomDialog(),
                                                      elevation: 12.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(12.r),
                                                          side: BorderSide(
                                                              width: 1.w,
                                                              color: Colors
                                                                  .blueAccent)));
                                                });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: themeController
                                                          .isDarkTheme.value
                                                      ? AppColors.backGroundDark
                                                      : AppColors
                                                          .backGroundLight,
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding: EdgeInsets.all(6.r),
                                                child: const Icon(Icons.call,
                                                    color: AppColors
                                                        .textColorGreen),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if(2 == 2) {
                                currectName.value = user.name;
                              saveName(user.name);
                              return const SizedBox.shrink();
                            }
                          }),
                    )
                  ],
                ),
              ),
              const BottomMenu(0),
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

  saveName(String name)async{
    await PrefsHelper.setString(AppConstants.name, name);
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

