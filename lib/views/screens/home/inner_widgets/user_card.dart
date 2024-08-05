
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? viewProfileOnTap;
  final bool isDark;

  const UserCard({super.key, required this.isDark, this.viewProfileOnTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
          width: 350.w,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xff192D36)
                : Colors.lightBlue.withOpacity(0.35),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(0, 6),
                blurRadius: 7,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: 'imageUrl',
                      height: 80.h,
                      width: 80.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: CustomText(
                            textAlign: TextAlign.start,
                            text: 'Sagor Ahamed',
                            fontsize: 16,
                            left: 13.w,
                            bottom: 7.h),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: CustomText(
                            textAlign: TextAlign.start,
                            text: 'I am learner here please help me. i am here to help',
                            maxline: 3,
                            left: 13.w,
                            bottom: 7.h),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStatColumn('15K', 'Minute'),
                  _buildStatColumn('82', 'Call'),
                  _buildStatColumn('20', 'Reviews'),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: viewProfileOnTap,
                    child: Container(
                      width: 130.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.blueAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(text: 'View Profile', color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 130.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.blueAccent),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(text: 'Call', color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        // SizedBox(height: 7.h)
      ],
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(text: count, fontsize: 16),
        CustomText(text: label)
      ],
    );
  }
}
