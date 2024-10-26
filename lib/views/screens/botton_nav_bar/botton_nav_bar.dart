import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_icons.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';






class BottomMenu extends StatefulWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {


  Color colorByIndex(ThemeData theme, int index) {
    return index == widget.menuIndex ? Colors.blueAccent : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SvgPicture.asset(
            image,
            width: 24.w,
            color: colorByIndex(theme, index),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(0 == widget.menuIndex ? AppIcons.home : AppIcons.home2, 'Home',
          theme, 0),
      getItem(1 == widget.menuIndex ? AppIcons.profile : AppIcons.profile,
          'Profile', theme, 1),
    ];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.lightBlue,
            selectedIconTheme: const IconThemeData(color: Colors.lightBlue),
            // unselectedIconTheme: IconThemeData(color: isDark ?? false ? Colors.white : Colors.black),
            currentIndex: widget.menuIndex,
            onTap: (value) {
              FocusScope.of(context).unfocus();
              switch (value) {
                case 0:
                  Get.offAndToNamed(AppRoutes.homeScreen);
                  break;
                case 1:
                  Get.offAndToNamed(AppRoutes.profileScreen);
                  break;
              }
            },
            items: menuItems,
          )
          ,
        ),
      ),
    );
  }
}