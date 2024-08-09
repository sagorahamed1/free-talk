// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:free_talk/services/theme_manager.dart';
// import 'package:get/get.dart';
// import '../../../utils/app_icons.dart';
// import '../home/home_screen.dart';
// import '../profile/profile_screen.dart';
//
//
//
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({super.key});
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavigationBarExampleState();
// }
//
// class _BottomNavigationBarExampleState extends State<BottomNavBar> {
//   int _selectedIndex = 0;
//   ThemeController themeController = Get.put(ThemeController());
//
//
//   static final List _widgetOptions = [
//     HomeScreen(),
//     ProfileScreen(),
//   ];
//
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: _widgetOptions.elementAt(_selectedIndex),
//
//       ///------------------------bottom nav bar----------------------------?>
//       bottomNavigationBar: Obx(()=>
//          BottomNavigationBar(
//
//           type: BottomNavigationBarType.fixed,
//           items: <BottomNavigationBarItem>[
//             ///---------------home---------------->
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                   AppIcons.home,
//                   color: themeController.isDarkTheme.value ? Colors.white : Colors.black
//               ),
//               label: 'Home',
//             ),
//
//
//
//             ///---------------profile---------------->
//             BottomNavigationBarItem(
//               icon:  SvgPicture.asset(
//                   AppIcons.profile,
//                   color: themeController.isDarkTheme.value ? Colors.white : Colors.black
//               ),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           showUnselectedLabels: false,
//           iconSize: 20.h,
//           backgroundColor: themeController.isDarkTheme.value ? const Color(0xff0D222B) : Colors.white,
//           selectedFontSize: 14.h,
//           selectedItemColor: themeController.isDarkTheme.value ? Colors.white : Colors.black,
//           unselectedItemColor: themeController.isDarkTheme.value ? Colors.white : Colors.black,
//
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';


class BottomMenu extends StatelessWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SvgPicture.asset(
            image,
            height: 24.0,
            width: 24.0,
            //         color: colorByIndex(theme, index),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(0 == menuIndex ? AppIcons.home : AppIcons.home, 'Home',
          theme, 0),
      getItem(1 == menuIndex ? AppIcons.profile : AppIcons.profile,
          'Profile', theme, 1),
    ];

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          currentIndex: menuIndex,
          onTap: (value) {
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
        ),
      ),
    );
  }
}