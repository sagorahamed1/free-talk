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
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'helpers/dependancy_injaction.dart';
import 'helpers/device_utils.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await FirebaseService.setUpFirebase();


  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);


  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );


    DeviceUtils.lockDevicePortrait();

    DependencyInjection di = DependencyInjection();
    di.dependencies();

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}



class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
   MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => Obx(()=>
        GetMaterialApp(
          navigatorKey: widget.navigatorKey,
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
