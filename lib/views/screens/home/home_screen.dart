import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/utils/gradient_box_decoration_custom.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';
import 'package:get/get.dart';

import 'inner_widgets/drawer_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;
  String selectedButton = 'basic';

  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    print('==========${themeController.isDarkTheme}');
    return Scaffold(
      body: Obx(
        () {
          themeController.isDarkTheme.value;
          return Stack(
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
                                      CustomText(
                                        text: "Sagor Ahamed",
                                      )
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
                                        Container(
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
                                                child: Icon(Icons.call),
                                              ),
                                              CustomText(
                                                text: "Call Now dddd",
                                              )
                                            ],
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
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: 10,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: index != 10-1 ? 16.w : 0),
                                          child: UserCard(
                                            isDark: themeController
                                                .isDarkTheme.value,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final bool isDark;

  const UserCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
      width: 350.w,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xff192D36)
            : Colors.lightBlue.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 6),
            blurRadius: 7,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl: 'imageUrl',
                  height: 80.h,
                  width: 80.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: CustomText(
                      textAlign: TextAlign.start,
                        text: 'Sagor Ahamed',
                        fontsize: 16,
                        left: 13.w,
                        bottom: 7.h),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: CustomText(
                      textAlign: TextAlign.start,
                        text: 'I am learner here please help me. i am here to help',
                        maxline: 3,
                        left: 13.w,
                        bottom: 7.h),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildStatColumn('15K', 'Minute'),
              _buildStatColumn('82', 'Call'),
              _buildStatColumn('20', 'Reviews'),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 130.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.blueAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: 'View Profile', color: Colors.white),
                ),
              ),
              Container(
                width: 130.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.blueAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(text: 'Call', color: Colors.white),
                ),
              )
            ],
          )
        ],
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
