import 'package:flutter/material.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/themes/themes.dart';
import 'package:free_talk/views/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await FirebaseService.setUpFirebase();
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
   MyApp({super.key});

  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => Obx(()=>
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Free Talk',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(),
            cardColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6200EE),
              onPrimary: Colors.white,
              secondary: Color(0xFF03DAC6),
              onSecondary: Colors.black,
              surface: Color(0xFFE0E0E0),
              onSurface: Colors.black,
              background: Color(0xFFF6F7FB),
              onBackground: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.blueGrey,
            scaffoldBackgroundColor: Color(0xFF1D1F33),
            textTheme: GoogleFonts.poppinsTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
            cardColor: Color(0xFF323548),
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFBB86FC),
              onPrimary: Colors.black,
              secondary: Color(0xFF03DAC6),
              onSecondary: Colors.black,
              surface: Color(0xFF121212),
              onSurface: Colors.white,
              background: Color(0xFF1D1F33),
              onBackground: Colors.white,
            ),
          ),
          themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          home: SplashScreen(),
        ),
      ),
      designSize: const Size(393, 852),
    );
  }
}
