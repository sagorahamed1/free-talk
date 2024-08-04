import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_icons.dart';
import '../home/home_screen.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavBar> {
  int _selectedIndex = 0;


  static final List _widgetOptions = [
    HomeScreen(),
    HomeScreen(),
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
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          ///---------------home---------------->
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppIcons.home,
                color: Colors.black
            ),
            label: 'Home',
          ),



          ///---------------profile---------------->
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(
                AppIcons.profile,
                color: Colors.black
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        iconSize: 20.h,
        backgroundColor: Colors.white,
        selectedFontSize: 14.h,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,

      ),
    );
  }
}