import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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










  var reviews = <UserProfileModel>[].obs;
  RxBool reviewsLoading = false.obs;

  /// Function to fetch review data based on user ID
  Future<void> reviewData(String id) async {
    reviewsLoading(true); // Start loading state
    try {
      // Fetch the document from the 'reviews' collection using the document ID
      DocumentSnapshot snapshot = await firebaseService.getData(id: id, collection: "reviews");

      // Check if the document exists
      if (snapshot.exists) {
        // Get the data from the document as a map
        var data = snapshot.data() as Map<String, dynamic>;

        // Assuming the document contains a list of user IDs under the key 'userIds'
        List<dynamic> userIds = data['userIds'] ?? [];

        // Check if the given ID matches any of the user IDs in the list
        if (userIds.contains(id)) {
          // Add the data to the reviews list if the user ID matches
          reviews.add(UserProfileModel.fromMap(data));
        }
      } else {
        debugPrint("Document with ID $id does not exist.");
      }

      reviewsLoading(false); // Stop loading state
    } catch (e) {
      reviewsLoading(false); // Stop loading state on error
      debugPrint("Error fetching users: $e");
    }
  }

}