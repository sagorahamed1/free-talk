import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/controllers/home_controller.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/utils/gradient_box_decoration_custom.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../botton_nav_bar/botton_nav_bar.dart';
import 'inner_widgets/drawer_section.dart';
import 'inner_widgets/top_card.dart';
import 'inner_widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;


  ThemeController themeController = Get.put(ThemeController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: value == 1 ?  const Color(0xff4f43b4) : themeController.isDarkTheme.value ?
            Colors.black : Colors.white
      )
    );
    // homeController.fetchAllUsers();
    print('==========${themeController.isDarkTheme}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: const BottomMenu(0),
      body: Obx(
        () {
          themeController.isDarkTheme.value;
          print("=======> home controller ${homeController.users.value}");
          return Container(
                  height: Get.height,
                  child: Stack(
                    children: [
                      ///======background color======>
                      Container(
                        color:  const Color(0xff4f43b4),
                      ),

                      ///====drawer section====>
                      drawerSection(
                        isDark: themeController.isDarkTheme.value,
                        onTap: () {
                          setState(() {
                            value == 0 ? value = 1 : value = 0;
                          });
                        },
                      ),

                      ///======main screen animation====.
                      homeController.userGetLoading.value
                          ? const CircularProgressIndicator()
                          :  TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: value),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, x, child) {
                          return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..setEntry(0, 3, 230 * x)
                                ..rotateY((pi / 6) * x),

                              ///========main body====>
                              child: Container(
                                clipBehavior: value == 0 ?  Clip.none : Clip.antiAlias,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: themeController.isDarkTheme.value
                                          ? const Color(0xff252c3b)
                                          : Colors.white,
                                ),

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 50.h),
                                          Row(
                                            children: [
                                              SizedBox(width: 20.w),
                                              value != 0
                                                  ? const SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          value == 0
                                                              ? value = 1
                                                              : value = 0;
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.menu)),
                                              SizedBox(width: 100.w),
                                              Text(
                                                "Sagor ddkfj;a",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700,
                                                    fontSize: 22.h,
                                                    color: themeController
                                                            .isDarkTheme.value
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///====top card===>
                                    const TopCard(),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20.h),

                                          ///====ads======.
                                          Container(
                                            height: 150.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xff0D222B)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.r),
                                                color:
                                                    const Color(0xff192D36)),
                                          ),
                                          SizedBox(height: 12.h),

                                          _SeeAll('Expert', 'See All', () {
                                            Get.toNamed(
                                                AppRoutes.allUserScreen);
                                          }),

                                          SizedBox(
                                            height: 230.h,
                                            child: ListView.builder(
                                              itemCount: homeController.users.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var user = homeController.users[index];
                                                if (homeController.currectUser != user.id) {
                                                 print("==${homeController.currectUser.value} = ${user.id}");

                                                  return Padding(
                                                    padding: EdgeInsets.only(right: index != 10 - 1 ? 16.w : 0),
                                                    child: UserCard(
                                                      name: user.name,
                                                      aboutMe: user.aboutMe,
                                                      totalCall: user.totalCall,
                                                      totalMinute: user.totalTalkTime,
                                                      totalReviews: user.totalReviews,
                                                      viewProfileOnTap: () {
                                                        Get.toNamed(AppRoutes.profileScreen);
                                                      },
                                                      isDark: themeController.isDarkTheme.value,
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox.shrink(); // No widget displayed for matching users
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    BottomMenu(0),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _SeeAll(String leftText, seeAllText, VoidCallback ontap) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(left: 7.w, text: leftText, fontsize: 20),
            GestureDetector(
              onTap: ontap,
              child: CustomText(right: 6.w, text: seeAllText, fontsize: 20),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
