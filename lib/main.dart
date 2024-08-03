import 'package:flutter/material.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/themes/themes.dart';
import 'package:free_talk/views/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}


ThemeManager themeManager = ThemeManager();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    themeManager.addListener(themeLister);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeLister);
    super.dispose();
  }

  themeLister(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'House Home Rent',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeManager.themeData,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          home: SplashScreen(),
        ),
        designSize: const Size(393, 852));
  }
}
