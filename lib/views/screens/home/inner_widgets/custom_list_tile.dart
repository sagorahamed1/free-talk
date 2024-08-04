
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const CustomListTile(
      {super.key,
        required this.title,
        required this.icon,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: onTap,
      ),
    );
  }
}
