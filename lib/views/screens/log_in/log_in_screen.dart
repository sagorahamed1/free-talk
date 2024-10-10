import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/controllers/auth_controller.dart';
import 'package:free_talk/helpers/toast_message_helper.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: kDebugMode ? 'sagorahammed002@gmail.com': '');
  TextEditingController passWordController = TextEditingController(text: kDebugMode ? '1qazxsw2': '');
  ThemeController themeController = Get.find<ThemeController>();
  AuthController authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=>
            Form(
              key: _formKey,
              child: Column(
                children: [

                  SizedBox(height: 64.h),

                  SizedBox(
                      height: 90.h,
                      child: Image.asset('assets/images/logo.png')),


                  SizedBox(height: 90.h),
                  // Sign In Text
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Welcome Back! Please enter your details.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: themeController.isDarkTheme.value ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  SizedBox(height: 30.h),


                  ///========email========
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: emailController,
                    hintText: 'Enter your email',
                    prefixIcon: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
                      child: SvgPicture.asset(AppIcons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required!";
                      } else if (!AppConstants.emailValidate.hasMatch(value)) {
                        return "Invalid email!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),


                  ///========password========>
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: passWordController,
                    isPassword: true,
                    hintText: 'Enter your email',
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
                      child: SvgPicture.asset(AppIcons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be 6 characters or letter!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),


                  GestureDetector(
                    onTap: (){
                      ToastMessageHelper.showToastMessage("Password reset request to ${emailController.text}.");
                      authController.forgotPassword(emailController.text);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  ///===========log in button======>
                  CustomBotton(
                    loading: authController.loginLoading.value,
                      title: 'Sign In', onpress: (){
                    if(_formKey.currentState!.validate()){
                      ///======log in code
                      authController.logIn(
                        email: emailController.text.trim(),
                        password: passWordController.text.trim(),
                      );



                      Future.delayed(const Duration(milliseconds: 300), () {
                        emailController.clear();
                        passWordController.clear();
                      });

                    }

                  }),



                  SizedBox(height: 24.h),

                  // Divider with OR
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
                          thickness: 1.2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or Sign In With",
                          style: TextStyle(
                            color: themeController.isDarkTheme.value ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
                          thickness: 1.2,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ///***********facebook**************/
                      GestureDetector(
                          onTap: (){
                            authController.facebookSign();
                          },
                          child: SvgPicture.asset(AppIcons.facebook)),

                      SizedBox(width: 20.w),
                      ///****************google ************.
                      GestureDetector(
                          onTap: (){
                            authController.googleLogin();
                          },
                          child: SvgPicture.asset(AppIcons.google)),

                    ],
                  ),


                  SizedBox(height: 18.h),
                  // Divider with OR
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
                          thickness: 1.2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            color: themeController.isDarkTheme.value ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
                          thickness: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),




                  // Register Button
                  OutlinedButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.signUpScreen);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side:  const BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 0.9,
                      ),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color:  Colors.lightBlueAccent,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
