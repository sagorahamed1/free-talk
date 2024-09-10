import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AuthController extends GetxController{


  FirebaseService firebaseService = FirebaseService();
  signUp({String? email,String? password, String? name,String? gender, String? country})async{
   User? userData = await firebaseService.registerWithEmailPassword(email!, password!);

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


  RxBool loginLoading = false.obs;
  ///=====log in===>
  logIn({String? email, String? password})async{
    loginLoading(true);
    User? user = await firebaseService.signInWithEmailPassword(email ?? '', password ?? '');
    print("=================================================log in done : ${user?.uid} \n ${user?.email}");

    if(user?.uid != null){
      await PrefsHelper.setString(AppConstants.currentUser, "${user?.uid}");
      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.name, user?.displayName);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      Get.toNamed(AppRoutes.homeScreen);
      loginLoading(false);
    }

    loginLoading(false);
  }




  forgotPassword(String email)async{
    firebaseService.sendPasswordResetEmail(email);
  }



  changePassword(String email, oldPassword, newPassword)async{
    firebaseService.changePassword(email, oldPassword, newPassword);
  }
}