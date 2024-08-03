import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:free_talk/views/base/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
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
              ///=======name======.
              CustomTextField(
                  controller: nameController,
                hintText: 'Enter your name',
              ),
              SizedBox(height: 16.h),



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


              ///========sign up button========
              CustomBotton(title: 'Sign Up', onpress: (){}),



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
    );
  }
}
