import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:get/get.dart';
import '../../../utils/app_icons.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  ThemeController themeController = Get.put(ThemeController());


  static final List _widgetOptions = [
    HomeScreen(),
    ProfileScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _widgetOptions.elementAt(_selectedIndex),

      ///------------------------bottom nav bar----------------------------?>
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            ///---------------home---------------->
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                  AppIcons.home,
                  color: themeController.isDarkTheme.value ? Colors.white : Colors.black
              ),
              label: 'Home',
            ),



            ///---------------profile---------------->
            BottomNavigationBarItem(
              icon:  SvgPicture.asset(
                  AppIcons.profile,
                  color: themeController.isDarkTheme.value ? Colors.white : Colors.black
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
          iconSize: 20.h,
          backgroundColor: themeController.isDarkTheme.value ? const Color(0xff0D222B) : Colors.white,
          selectedFontSize: 14.h,
          selectedItemColor: themeController.isDarkTheme.value ? Colors.white : Colors.black,
          unselectedItemColor: themeController.isDarkTheme.value ? Colors.white : Colors.black,

        ),
      ),
    );
  }
}