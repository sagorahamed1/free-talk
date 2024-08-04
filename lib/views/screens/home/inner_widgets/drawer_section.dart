
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../services/theme_manager.dart';
import '../../../base/custom_network_image.dart';
import '../../../base/custom_text.dart';
import 'custom_list_tile.dart';

class drawerSection extends StatefulWidget {
  final VoidCallback onTap;
  const drawerSection({super.key, required this.onTap});

  @override
  State<drawerSection> createState() => _drawerSectionState();
}

class _drawerSectionState extends State<drawerSection> {
  ThemeManager themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    print("===============> theme : ${themeManager.themeData}");
    return Container(
      height: double.infinity,
      width: 250.w,
      color: Colors.deepPurple,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          ListTile(
            leading: CustomNetworkImage(
              boxShape: BoxShape.circle,
              imageUrl: 'll',
              height: 50.h,
              width: 50.w,
            ),
            title: Text('Sagor Ahamed',
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: CustomText(text: "software developer"),
            trailing: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                    child: Icon(Icons.close))),
          ),

          CustomListTile(
            title: 'Change Password',
            icon: Icon(Icons.confirmation_num_sharp),
            onTap: () {},
          ),

          CustomListTile(
            title: 'Setting',
            icon: const Icon(Icons.settings),
            onTap: () {},
          ),

          CustomListTile(
            title: 'Bangladesh',
            icon: Icon(Icons.co2),
            onTap: () {},
          ),

          ///===========theme change====>
          CustomListTile(
            title: themeManager.themeData == ThemeMode.light
                ? 'Light Theme'
                : 'Dark Theme',
            icon: themeManager.themeData == ThemeMode.light
                ? Icon(Icons.light_mode)
                : Icon(Icons.dark_mode_outlined),
            onTap: () {
              if (themeManager.themeData == ThemeMode.light) {
                setState(() {
                  themeManager.toggleThme(true);
                });
              } else if (themeManager.themeData == ThemeMode.dark) {
                setState(() {
                  themeManager.toggleThme(false);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}