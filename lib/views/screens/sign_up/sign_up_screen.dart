import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk/controllers/auth_controller.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_pupup_menu.dart';
import '../../base/custom_text.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
   ThemeController themeController = Get.find<ThemeController>();
   AuthController authController = Get.find<AuthController>();
   var popUpLists = ['Male', 'Female'];
   RxString selectedPopUp = "Male".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=> Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  children: [
              
              
                    SizedBox(height: 40.h),
              
                    SizedBox(
                        height: 90.h,
                        child: Image.asset('assets/images/logo.png')),
              
              
                    SizedBox(height: 50.h),
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
                    SizedBox(height: 20.h),
              
              
              
              
              
              
              
                    ///=======name======.
                    CustomTextField(
                      isDark: themeController.isDarkTheme.value,
                        controller: nameController,
                      hintText: 'Enter your name',
                      prefixIcon:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(AppIcons.profile),
                      ),
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
                      prefixIcon:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(AppIcons.email),
                      ),
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
                      readOnly: true,
                      prefixIcon:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(AppIcons.manWoman, height: 22.h,),
                      ),
                      isDark: themeController.isDarkTheme.value,
                      controller: genderController,
                      hintText: 'Enter your gender',
                      suffixIcon: PopUpMenu(
                        style: const TextStyle(color: Colors.white),
                        items: popUpLists,
                        selectedItem: selectedPopUp.value,
                        onTap: (int index) {
                          genderController.text = popUpLists[index].toString();
                          selectedPopUp.value = popUpLists[index].toString();
                          PopUpMenu.selectedValue.value = selectedPopUp.value;
                          Future.delayed(const Duration(milliseconds: 300), () => Navigator.pop(context));
                        },
                      ),
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
                      prefixIcon:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(AppIcons.flag),
                      ),
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
                      prefixIcon:  Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(AppIcons.lock),
                      ),
                      isDark: themeController.isDarkTheme.value,
                      controller: passWordController,
                      isPassword: true,
                      hintText: 'Enter your password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password must be 6 characters or letter!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
              
              
                    ///========sign up button========
                    CustomBotton(
                        loading: authController.signUpLoading.value,
                        title: 'Sign Up', onpress: (){
                      if(_formKey.currentState!.validate()){
                        /// sign up handle
                        authController.signUp(
                            email : emailController.text.trim(),
                            password:  passWordController.text.trim(),
                            name: nameController.text,
                            gender: genderController.text,
                            country: countryController.text
                        );


                        Future.delayed(const Duration(milliseconds: 300), () {
                          emailController.clear();
                          passWordController.clear();
                          nameController.clear();
                          genderController.clear();
                          countryController.clear();
                        });

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
                          child:
                          Text(
                            " ${AppStrings.login}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color:  Colors.blueAccent,
                            ),
                          ),
              
                        ),
                      ],
                    ),



              
              
                  ],
                ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}
