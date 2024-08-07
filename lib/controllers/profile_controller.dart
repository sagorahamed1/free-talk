import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController{


  FirebaseService firebaseService = FirebaseService();

  var data = '';

  ///=====get profile data===>
  getProfileData({String? userId})async{
    var currentUser = await PrefsHelper.getString(AppConstants.currentUser);
    DocumentSnapshot user = await firebaseService.getData(collection: 'user', id: currentUser);



    print("log in done : ${user}  : type : ${user.runtimeType}");


    Get.toNamed(AppRoutes.bottomNavBar);
  }
}