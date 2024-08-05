import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
   ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=> Form(
            key: _formKey,
            child: Column(
                children: [

                  SizedBox(height: 50.h),
                  ///=======name======.
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                      controller: nameController,
                    hintText: 'Enter your name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  ///========email========
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: emailController,
                    hintText: 'Enter your email',
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



                  ///========Gender========
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: genderController,
                    hintText: 'Enter your gender',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Gender is required!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),


                  ///========Country========
                  CustomTextField(
                    isDark: themeController.isDarkTheme.value,
                    controller: countryController,
                    hintText: 'Enter your country',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Country is required!";
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8 || !AppConstants.validatePassword(value)) {
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),


                  ///========sign up button========
                  CustomBotton(title: 'Sign Up', onpress: (){
                    if(_formKey.currentState!.validate()){
                      /// sign up handle
                    }
                  }),



                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: AppStrings.youAllreadyHaveanAcount),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(AppRoutes.logInScreen);
                        },
                        child: CustomText(
                            text: AppStrings.login),
                      ),
                    ],
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
