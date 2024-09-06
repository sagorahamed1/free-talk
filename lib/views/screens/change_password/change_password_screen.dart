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

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currectPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController reNewPassCtrl = TextEditingController();

  ThemeController themeController = Get.put(ThemeController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: themeController.isDarkTheme.value ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
        centerTitle: true,
        title:  Text(
          'Change Password',
          style: TextStyle(
            fontSize: 17.h,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(()=> Form(
            key: _formKey,
            child: Column(
              children: [



                SizedBox(height: 120.h),


                ///=======old password======.
                CustomTextField(
                  isDark: themeController.isDarkTheme.value,
                  controller: currectPassCtrl,
                  hintText: 'Enter your old password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                ///========new password========
                CustomTextField(
                  isDark: themeController.isDarkTheme.value,
                  controller: newPassCtrl,
                  hintText: 'Enter your new password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "New password is required!";
                    } else if (!AppConstants.emailValidate.hasMatch(value)) {
                      return "";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),



                ///========Gender========
                CustomTextField(
                  isDark: themeController.isDarkTheme.value,
                  controller: reNewPassCtrl,
                  hintText: 'Enter your re-new password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "re-new password is required!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 60.h),





                ///========Update Password========
                CustomBotton(title: 'Update Password', onpress: (){
                  if(_formKey.currentState!.validate()){

                  }
                }),






              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
