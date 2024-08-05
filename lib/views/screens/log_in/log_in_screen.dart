import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=>
            Column(
              children: [

                SizedBox(height: 50.h),
                ///========email========
                CustomTextField(
                  isDark: themeController.isDarkTheme.value,
                  controller: emailController,
                  hintText: 'Enter your email',
                ),
                SizedBox(height: 16.h),


                ///========password========>
                CustomTextField(
                  isDark: themeController.isDarkTheme.value,
                  controller: passWordController,
                  isPassword: true,
                  hintText: 'Enter your email',
                ),
                SizedBox(height: 40.h),


                ///===========log in button======>
                CustomBotton(title: 'Log In', onpress: (){
                  Get.toNamed(AppRoutes.bottomNavBar);
                }),



                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppStrings.nohaveAcout),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(AppRoutes.signUpScreen);
                      },
                      child: CustomText(
                          text: AppStrings.signUp),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
