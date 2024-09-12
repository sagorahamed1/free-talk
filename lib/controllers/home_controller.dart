import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/firebase_services.dart';

class HomeController extends GetxController {
  FirebaseService firebaseService = FirebaseService();
  var users = <UserProfileModel>[].obs;
  RxBool userGetLoading = false.obs;
  // RxString currectUser = ''.obs;



  ///===== Fetch all users data ===>
  Future<void> fetchAllUsers() async {
    userGetLoading(true);
    // currectUser.value = await PrefsHelper.getString(AppConstants.currentUser);
    try {
      QuerySnapshot snapshot = await firebaseService.getAllData(collection: 'users');

      users.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return UserProfileModel.fromMap(data);
      }).toList();
      userGetLoading(false);
    } catch (e) {
      print("Error fetching users: $e");
    }
  }





  review({required String senderId, receverId, description, reviewerName, rating, feeling, })async{
    var body = {
      "description" : "$description",
      "reviewName" : "$reviewerName",
      "rating" : "$rating",
      "feeling" : "$feeling",
      "reviewId" : "$senderId"
    };
    firebaseService.appendReviewToList("receverId", body, collectionName: "reviews");

    Get.offNamed(AppRoutes.homeScreen);
  }




  RxInt availeGenderSelectedIndex = 0.obs;
  RxList availeGenderList = [
    {
      'title' : 'any',
      'icon' : AppIcons.manWoman
    },
    {
      'title' : 'girl',
      'icon' : AppIcons.girl
    },
    {
      'title' : 'boy',
      'icon' : AppIcons.man
    }
  ].obs;








  var secondsRemaining = 30.obs;  // Observable for the timer
  var buttonLabel = "Start Call".obs;  // Observable for the button label
  late Timer _timer;
  var isCalling = false.obs; // Track call state

  @override
  void onInit() {
    super.onInit();
    buttonLabel.value = "Start Call";  // Initial button label
  }

  void startTimer() {
    if (!isCalling.value) {
      // Start the call
      isCalling.value = true;
      buttonLabel.value = "Calling";  // Change button label to "Calling"

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (secondsRemaining.value > 0) {
          secondsRemaining.value--;
        } else {
          // Reset after 50 seconds
          buttonLabel.value = "Start Call";  // Reset button label
          isCalling.value = false;  // Reset call state
          secondsRemaining.value = 50;  // Reset the timer
          _timer.cancel();
        }
      });
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
