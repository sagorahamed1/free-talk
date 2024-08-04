import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/utils/gradient_box_decoration_custom.dart';
import 'package:free_talk/views/base/custom_network_image.dart';
import 'package:free_talk/views/base/custom_text.dart';

import 'inner_widgets/drawer_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 0;
  String selectedButton = 'basic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///======background color======>
          Container(
            color: Colors.deepPurple,
          ),

          ///====drawer section====>
          drawerSection(
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
                    decoration: gradientBoxDecorationCustom(),
                    child: Column(
                      children: [
                        Container(
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
                                  SizedBox(width: 50.w),
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
                                color: Colors.lightBlue.shade100),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 25.h),

                              ///=====Call Card======>
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20.h),

                                    ///==========Call Icons==========>
                                    Container(
                                      width: 200.w,
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.r),
                                          color: Colors.blue),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 12.w, top: 16.h, bottom: 16.h),
                                            child: Icon(Icons.call),
                                          ),

                                          CustomText(text: "Call Now dddd",)
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20.h),

                                    ///========select gender=======>
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:
                                          ['Any', 'Female', 'Male'].map((name) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedButton = name;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 550),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            padding: const EdgeInsets.symmetric(
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
                                                  color: selectedButton == name
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

                        ///====ads======.
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              Container(
                                height: 150.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.lightGreen),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            color: index % 2 != 0
                                                ? Colors.lightBlue
                                                    .withOpacity(0.35)
                                                : Colors.deepPurpleAccent
                                                    .withOpacity(0.8)),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0.r),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomNetworkImage(
                                                      boxShape: BoxShape.circle,
                                                      imageUrl: 'imageUrl',
                                                      height: 50.h,
                                                      width: 50.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        left: 12.w,
                                                        text: "Sagor Ahamed",
                                                      ),
                                                      CustomText(
                                                        left: 12.w,
                                                        text: "Basic",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.call),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
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
      ),
    );
  }
}
