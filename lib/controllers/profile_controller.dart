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

  Rx<UserProfileModel> userData = UserProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  ///===== Get profile data for current user ===>
  Future<void> getProfileData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await firebaseService.getData(
          collection: 'users',
          id: currentUser.uid,
        );

        var data = userSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          userData.value = UserProfileModel.fromMap(data);
          print("User data fetched: ${userData.value}");
        }
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }
}