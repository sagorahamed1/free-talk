import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/theme_manager.dart';
import '../../../base/custom_text.dart';

class TopCard extends StatefulWidget {
  const TopCard({super.key});

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {

  ThemeController themeController = Get.put(ThemeController());
  String selectedButton = 'any';
  @override
  Widget build(BuildContext context) {
    return                                     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              // border: Border.all(color: Colors.grey),
              color: themeController
                  .isDarkTheme.value
                  ? const Color(0xff192D36)
                  : Colors.lightBlue.shade100),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20.h),

            ///=====Call Card======>
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(16.r),
                color: themeController
                    .isDarkTheme.value
                    ? const Color(0xff0D222B)
                    : Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),

                  ///==========Call Icons==========>
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes
                          .reviewScreen);
                    },
                    child: Container(
                      width: 200.w,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(
                              12.r),
                          color: Colors.blue),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(
                                right: 12.w,
                                top: 16.h,
                                bottom:
                                16.h),
                            child: const Icon(
                                Icons.call),
                          ),
                          CustomText(
                            text:
                            "Call Now dddd",
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  ///========select gender=======>
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      'Any',
                      'Female',
                      'Male'
                    ].map((name) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButton =
                                name;
                          });
                        },
                        child:
                        AnimatedContainer(
                          duration:
                          const Duration(milliseconds:550),
                          margin:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          padding:
                          const EdgeInsets
                              .symmetric(
                              vertical: 10.0,horizontal: 20.0),
                          decoration:
                          BoxDecoration(
                            color:
                            selectedButton == name
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius:
                            BorderRadius
                                .circular(
                                20),
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
                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize: 13,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 18.h),
                ],
              ),
            ),
          )),
    );
  }
}
