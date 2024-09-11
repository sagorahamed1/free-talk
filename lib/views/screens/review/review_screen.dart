import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../controllers/home_controller.dart';
import '../../../services/theme_manager.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ThemeController themeController = Get.put(ThemeController());
  final HomeController homeController = Get.put(HomeController());

  TextEditingController reviewCtrl = TextEditingController();

  String selectedButton = 'Great';
  RxInt rating = 0.obs;
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("==============sender : ${data['senderId']}");
    print("==============receiverId : ${data['receiverId']}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=> Column(
              children: [
                SizedBox(height: 50.h),


                Text(
                  "Review",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.h,
                      color: themeController.isDarkTheme.value
                          ? Colors.white
                          : Colors.black),
                ),

                SizedBox(height: 18.h),
                Obx(()=>
                   RatingBar.builder(
                    initialRating: rating.value.toDouble(),
                    minRating: 1,
                    unratedColor: const Color(0xffC0C0C0),
                    itemCount: 5,
                    updateOnDrag: true,
                    wrapAlignment: WrapAlignment.start,
                    itemSize: 40.h,
                    itemBuilder: (context, index) {
                      return const Icon(Icons.star, color: Color(0xffFFB701));
                    },
                    onRatingUpdate: (value) {
                      rating.value = value.toInt();
                    },
                  ),
                ),

                SizedBox(height: 18.h),
                CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: reviewCtrl,
                    maxLine: 4,
                    hintText: 'Type something about this call...',
                ),

                SizedBox(height: 50.h),


                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: ['Great', 'Bed']
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


                SizedBox(height: 100.h),
                CustomBotton(title: 'Review', onpress: (){
                  homeController.review(

                    senderId: "${data['senderId']}",
                    receverId: "${data['receiverId']}",
                    description: reviewCtrl.text,
                    feeling: "$selectedButton",
                    rating: rating.value,
                    reviewerName: "${data['name']}"
                  );
                  // Get.offNamed(AppRoutes.homeScreen);
                }),

                SizedBox(height: 30.h),
                CustomBotton(title: 'later', onpress: (){
                  Get.offNamed(AppRoutes.homeScreen);
                }),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
