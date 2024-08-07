import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/controllers/auth_controller.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/theme_manager.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());

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

                  SizedBox(height: 50.h),
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


                  ///===========log in button======>
                  CustomBotton(title: 'Log In', onpress: (){
                    if(_formKey.currentState!.validate()){
                      ///======log in code
                      authController.logIn(
                        email: emailController.text,
                        password: passWordController.text.trim()
                      );
                    }

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
      ),
    );
  }
}
