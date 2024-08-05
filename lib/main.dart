import 'package:flutter/material.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/services/theme_manager.dart';
import 'package:free_talk/themes/themes.dart';
import 'package:free_talk/views/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
          theme: lightTheme,
          darkTheme: darkTheme,
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
