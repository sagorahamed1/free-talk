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

  // @override
  // void onInit() {
  //   super.onInit();
  //   getProfileData();
  // }

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





  var reviews = <ReviewModel>[].obs;  // Observable list for storing review data
  RxBool reviewsLoading = false.obs;       // Observable for loading state

  /// Function to fetch review data based on user ID
  Future<void> reviewData(String id) async {
    reviewsLoading(true); // Start loading state
    try {
      // Fetch the document from the 'reviews' collection using the document ID
      DocumentSnapshot snapshot = await firebaseService.getData(id: "receverId", collection: "reviews");

      // Check if the document exists
      if (snapshot.exists) {
        // Get the data from the document
        var data = snapshot.data() as Map<String, dynamic>;

        // Assuming the document contains a list of reviews (e.g., under 'reviewsList')
        List<dynamic> reviewsList = data['reviewsList'] ?? [];

        print("========>> ${reviewsList}");
        // Iterate over the list and convert each review to UserProfileModel
        for (var reviewData in reviewsList) {
          reviews.add(ReviewModel.fromMap(reviewData));
        }
      } else {
        debugPrint("Document with ID $id does not exist.");
      }

      reviewsLoading(false); // Stop loading state
    } catch (e, s) {
      reviewsLoading(false); // Stop loading state on error
      debugPrint("Error fetching reviews: $e");
      debugPrint("Error fetching reviews: $s");
    }
  }

}