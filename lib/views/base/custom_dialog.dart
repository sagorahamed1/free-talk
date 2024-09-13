
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
      MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape
                        .circle,
                    border: Border.all(
                        color: Colors
                            .blueAccent)),
                child: const Icon(
                    Icons.close),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          "Talk for 100 minutes to chat with a lovely girl. Keep talking, you're close! 😆😆",
          // 'Congrats! You\'ve crossed 100 talk minutes! You\'re now eligible to connect with female participants. Keep chatting and enjoy!',
          style: TextStyle(
            fontSize: 16.h,
            fontWeight:
            FontWeight.bold,
            color: Theme.of(
                context)
                .colorScheme
                .onBackground,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
