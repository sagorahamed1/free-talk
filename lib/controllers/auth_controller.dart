import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/helpers/toast_message_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class AuthController extends GetxController{


  FirebaseService firebaseService = FirebaseService();
  RxBool signUpLoading = false.obs;
  signUp({String? email,String? password, String? name,String? gender, String? country})async{
    signUpLoading(true);
   User? userData = await firebaseService.registerWithEmailPassword(email!, password!);


   print('=====> user Create : ${userData?.uid}');
   Map <String, dynamic> body = {
     'name' : "$name",
     'email' : email,
     'gender' : gender ?? "Male",
     'id' : "${userData?.uid}",
     'country' : country,
     'about_me' : 'I am search new friend for practice languages',
     'label' : 'Basic',
     'coin' : '0',
     'total_talk_time' : '0',
     'total_call' : '0',
     'image' : gender == "Male" ? 'https://www.icon0.com/free/static2/preview2/stock-photo-avatar-male-in-glasses-people-icon-character-cartoon-33223.jpg' : 'https://t3.ftcdn.net/jpg/06/49/36/36/360_F_649363606_DxINGavthJcaBzFuQk7Z3OOcbVOBTQyH.jpg',
     'total_review' : '0'
   };


    signUpLoading(false);
   await PrefsHelper.setString(AppConstants.currentUser, userData?.uid);
   await PrefsHelper.setString(AppConstants.name, "$name");
   var data = firebaseService.postData(userData?.uid ?? '', body);

   ToastMessageHelper.showToastMessage("Your account create successful");
   Get.offAllNamed(AppRoutes.logInScreen);

   print("====data : $data");
  }



  ///********************google sign in****************.
  googleLogin()async{
    UserCredential data = await firebaseService.signInWithGoogle();
    if(data.user != null){
      Get.offAllNamed(AppRoutes.homeScreen);
      Map <String, dynamic> body = {
        'name' : "${data.user?.displayName}",
        'email' : "${data.user?.email}",
        'gender' : "Male",
        'id' : "${data.user?.uid}",
        'country' : "Default Country",
        'about_me' : 'I am search new friend for practice languages',
        'label' : 'Basic',
        'coin' : '0',
        'total_talk_time' : '0',
        'total_call' : '0',
        'image' : '${data.user?.photoURL}',
        'total_review' : '0'
      };

      await PrefsHelper.setString(AppConstants.currentUser,"${data.user?.uid}");
      await PrefsHelper.setString(AppConstants.name, "${data.user?.displayName}");
      firebaseService.postData(data.user?.uid ?? '', body);
      await PrefsHelper.setString(AppConstants.email, data.user?.email);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      ToastMessageHelper.showToastMessage("sign in successful");

    }


  }



  ///********************google sign in****************.
  facebookSign()async{
    UserCredential? data = await firebaseService.signInWithFacebook();
    if(data?.user != null){
      Get.offAllNamed(AppRoutes.homeScreen);
      Map <String, dynamic> body = {
        'name' : "${data?.user?.displayName}",
        'email' : "${data?.user?.email}",
        'gender' : "Male",
        'id' : "${data?.user?.uid}",
        'country' : "Default Country",
        'about_me' : 'I am search new friend for practice languages',
        'label' : 'Basic',
        'coin' : '0',
        'total_talk_time' : '0',
        'total_call' : '0',
        'image' : '${data?.user?.photoURL}',
        'total_review' : '0'
      };

      await PrefsHelper.setString(AppConstants.currentUser,"${data?.user?.uid}");
      await PrefsHelper.setString(AppConstants.name, "${data?.user?.displayName}");
      await PrefsHelper.setString(AppConstants.email, "${data?.user?.email}" ?? '');
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      firebaseService.postData(data?.user?.uid ?? '', body);
      ToastMessageHelper.showToastMessage("sign in successful");

    }

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

      await PrefsHelper.setBool(AppConstants.isLogged, true);
      Get.offAllNamed(AppRoutes.homeScreen);
      loginLoading(false);

    }else{
      loginLoading(false);
    }
    loginLoading(false);
  }




  ///***************forgot password****************
  forgotPassword(String email)async{
    firebaseService.sendPasswordResetEmail(email);
  }



  ///*********************change password**************************
  changePassword(String email, oldPassword, newPassword)async{
    firebaseService.changePassword(email, oldPassword, newPassword);
  }
}