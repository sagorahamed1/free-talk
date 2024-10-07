import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';

import '../models/review_model.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController{


  FirebaseService firebaseService = FirebaseService();
  Rx<UserProfileModel> userData = UserProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    // reviewData();
  }

  ///===== Get profile data for current user ===>
  Future<void> getProfileData(String userId) async {
    print("============================================================userId $userId");
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser?.uid != null) {
        DocumentSnapshot userSnapshot = await firebaseService.getData(
          collection: 'users',
          id: userId,
        );

        var data = userSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          userData.value = UserProfileModel.fromMap(data);
          await PrefsHelper.setString(AppConstants.image, userData.value.image);
          print("User data fetched: ${userData.value}");
        }
      } else {
        print("No user is currently logged in.");
      }
    } catch (e, s) {
      print("Error fetching profile data: $e");
      print("Error fetching profile data: $s");
    }
  }





  var reviews = <ReviewModel>[].obs;
  RxBool reviewsLoading = false.obs;

  /// Function to fetch review data based on user ID
  Future<void> reviewData(String receverId) async {
    reviewsLoading(true);
    try {
      DocumentSnapshot snapshot = await firebaseService.getData(id: "$receverId", collection: "reviews");
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> reviewsList = data['reviewsList'] ?? [];

        for (var reviewData in reviewsList) {
          print("-------------------------------------Reviews $reviewData");
          reviews.add(ReviewModel.fromMap(reviewData));
        }
      } else {
        debugPrint("Document with ID does not exist.");
      }

      reviewsLoading(false);
    } catch (e, s) {
      reviewsLoading(false);
      debugPrint("Error fetching reviews: $e");
      debugPrint("Error fetching reviews: $s");
    }
  }

}