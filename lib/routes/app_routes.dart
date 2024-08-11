
import 'package:free_talk/views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import '../views/screens/all_user/all_user_screen.dart';
import '../views/screens/edit_profile/edit_profile_screen.dart';
import '../views/screens/home/home_screen.dart';
import '../views/screens/log_in/log_in_screen.dart';
import '../views/screens/profile/profile_screen.dart';
import '../views/screens/review/review_screen.dart';
import '../views/screens/sign_up/sign_up_screen.dart';


class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String signUpScreen = "/SignUpScreen.dart";
  static const String logInScreen = "/LogInScreen.dart";
  static const String profileScreen = "/ProfileScreen.dart";
  static const String allUserScreen = "/AllUserScreen.dart";
  static const String reviewScreen = "/ReviewScreen.dart";
  static const String homeScreen = "/HomeScreen.dart";
  static const String editProfileScreen = "/EditProfileScreen.dart";


  static List<GetPage> get routes => [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: logInScreen, page: () => LogInScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: allUserScreen, page: () => AllUserScreen()),
    GetPage(name: reviewScreen, page: () => ReviewScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
  ];
}