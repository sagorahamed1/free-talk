
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_text.dart';

class PrivacyPolicyAllScreen extends StatelessWidget {
  PrivacyPolicyAllScreen({super.key});

  var screenType = Get.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
       Get.isDarkMode ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? const Color(0xff1d1b32) : const Color(0xffdae5ef),
        title:  Text(
            screenType['screenType'] == AppStrings.privacyPolicy
                ? "Privacy Policy"
                : screenType['screenType'] == AppStrings.termsConditions
                ? "Terms Conditions"
                : screenType['screenType'] == AppStrings.aboutUs
                ? "aboutUs".tr
                : '',
          style: TextStyle(
            fontSize: 17.h,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomText(
              textAlign: TextAlign.start,
              maxline: 100000,
              fontsize: 16.h,
              color: Colors.red,
              text:
              'Welcome to [Company Name], your trusted partner in [specific service industry, e.g., home maintenance, IT solutions, healthcare, etc.]. We are dedicated to providing top-notch services tailored to meet your unique needs. Our team of experienced professionals is committed to delivering excellence with every project, ensuring that you receive the highest quality service and supportAt [Company Name], we believe in building lasting relationships with our clients through transparency, reliability, and exceptional service. Our mission is to make your life easier by offering comprehensive solutions that save you time and effort. Whether you need [specific services offered, e.g., plumbing repairs, software development, medical consultations], we are here to help ,Thank you for choosing [Company Name]. We look forward to serving you and exceeding your expectations.',
            )
          ],
        ),
      ),
    );
  }
}