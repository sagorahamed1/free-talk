import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [

              SizedBox(height: 50.h),
              ///========email========
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
              ),
              SizedBox(height: 16.h),


              ///========password========>
              CustomTextField(
                controller: passWordController,
                isPassword: true,
                hintText: 'Enter your email',
              ),
              SizedBox(height: 40.h),


              ///===========log in button======>
              CustomBotton(title: 'Log In', onpress: (){}),



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
    );
  }
}
