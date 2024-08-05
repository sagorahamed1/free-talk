import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/utils/gradient_box_decoration_custom.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import 'inner_widgets/drawer_section.dart';
import 'inner_widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;
  String selectedButton = 'any';

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    print('==========${themeController.isDarkTheme}');
    return Scaffold(
      body: Obx(
        () {
          themeController.isDarkTheme.value;
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Stack(
                children: [
                  ///======background color======>
                  Container(
                    color: themeController.isDarkTheme.value
                        ? const Color(0xff0D222B)
                        : Colors.white,
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

                  ///======drawer & main screen animaition====.
                  TweenAnimationBuilder(
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
                            width: double.infinity,
                            decoration: gradientBoxDecorationCustom(
                                themeController.isDarkTheme.value
                                    ? const Color(0xff0D222B)
                                    : Colors.white,
                                themeController.isDarkTheme.value
                                    ? const Color(0xff0D222B)
                                    : const Color(0xFFd2dfca)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100.h,
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
                                                  child: const Icon(Icons.menu)),
                                          SizedBox(width: 100.w),
                                          Text(
                                            "Sagor ddkfj;a",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22.h,
                                                color: themeController.isDarkTheme.value
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                ///====top card===>
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(16.r),
                                            bottomLeft: Radius.circular(16.r)),
                                        // border: Border.all(color: Colors.grey),
                                        color: themeController.isDarkTheme.value
                                            ? const Color(0xff192D36)
                                            : Colors.lightBlue.shade100),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 25.h),

                                      ///=====Call Card======>
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16.r),
                                          color: themeController.isDarkTheme.value
                                              ? const Color(0xff0D222B)
                                              : Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20.h),

                                            ///==========Call Icons==========>
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(AppRoutes.reviewScreen);
                                              },
                                              child: Container(
                                                width: 200.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(12.r),
                                                    color: Colors.blue),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 12.w,
                                                          top: 16.h,
                                                          bottom: 16.h),
                                                      child: const Icon(Icons.call),
                                                    ),
                                                    CustomText(
                                                      text: "Call Now dddd",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20.h),

                                            ///========select gender=======>
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: ['Any', 'Female', 'Male']
                                                  .map((name) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedButton = name;
                                                    });
                                                  },
                                                  child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 550),
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 20.0),
                                                    decoration: BoxDecoration(
                                                      color: selectedButton == name
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: selectedButton ==
                                                                  name
                                                              ? Colors.blueAccent
                                                              : Colors.grey,
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      name,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),

                                            SizedBox(height: 20.h),
                                          ],
                                        ),
                                      ),
                                    )),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),

                                      ///====ads======.
                                      Container(
                                        height: 150.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff0D222B)),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: const Color(0xff192D36)),
                                      ),
                                      SizedBox(height: 12.h),

                                      _SeeAll('Expert', 'See All', (){
                                        Get.toNamed(AppRoutes.allUserScreen);
                                      }),

                                      SizedBox(
                                         height: 230.h,
                                        child: ListView.builder(
                                          itemCount: 10,
                                          scrollDirection: Axis.horizontal,
                                           shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  right: index != 10-1 ? 16.w : 0),
                                              child: UserCard(
                                                viewProfileOnTap: (){
                                                  Get.toNamed(AppRoutes.profileScreen);
                                                },
                                                isDark: themeController
                                                    .isDarkTheme.value,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ],
              ),
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
            CustomText(
              left: 7.w,
                text: leftText,
                fontsize: 20),
            GestureDetector(
              onTap: ontap,
              child: CustomText(
                right: 6.w,
                  text: seeAllText,
                  fontsize: 20),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
