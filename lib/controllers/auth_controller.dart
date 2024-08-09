import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  FirebaseService firebaseService = FirebaseService();
  signUp({String? email,String? password, String? name,String? gender, String? country})async{
   User? userData =await firebaseService.registerWithEmailPassword(email!, password!);

   print('=====> user Create : ${userData?.uid}');
   Map <String, dynamic> body = {
     'name' : "$name",
     'email' : email,
     'gender' : gender,
     'country' : country,
     'about_me' : 'I am search new friend for practice languages',
     'label' : '',
     'coin' : '',
     'total_talk_time' : '',
     'total_call' : '',
     'image' : '',
     'total_review' : ''
   };
   await PrefsHelper.setString(AppConstants.currentUser, userData?.uid);
   var data = firebaseService.postData(userData?.uid ?? '', body);

   Get.toNamed(AppRoutes.logInScreen);
   print("====data : $data");
  }


  ///=====log in===>
  logIn({String? email, String? password})async{
    User? user =await firebaseService.signInWithEmailPassword(email ?? '', password ?? '');
    print("log in done : $user");

    await PrefsHelper.setString(AppConstants.currentUser, user?.uid);
    await PrefsHelper.setBool(AppConstants.isLogged, true);
    Get.toNamed(AppRoutes.homeScreen);
  }
}