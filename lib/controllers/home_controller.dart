import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_talk/controllers/profile_controller.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:free_talk/utils/app_icons.dart';
import 'package:free_talk/views/screens/call/voice_call_screen.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/firebase_services.dart';
import '../utils/utils.dart';

class HomeController extends GetxController {
  FirebaseService firebaseService = FirebaseService();
  var users = <UserProfileModel>[].obs;
  RxBool userGetLoading = false.obs;



  ///******************Create Room***************...
  void createRoom(String roomId) async {
    await Utils.signaling.openUserMedia(Utils.localRenderer, Utils.remoteRenderer).then((_) async {
      update();
    });
    Utils.roomId = await Utils.signaling.createRoom(Utils.remoteRenderer, roomId.toString());
    Get.to(const VoiceCallScreen());
    // Get.to(const VoiceCallScreen());
  }

  void joinRoom(String roomId) async {
    await Utils.signaling
        .openUserMedia(Utils.localRenderer, Utils.remoteRenderer)
        .then((_) async {
      update();
    });
    Utils.signaling.joinRoom(
      "$roomId",
      Utils.remoteRenderer,
    );
    // Utils.roomId = roomCtrl.text.trim();
    Get.to(const VoiceCallScreen());
    // Get.to(const VoiceCallScreen());
  }


  ///===== Fetch all users data ===>
  Future<void> fetchAllUsers() async {
    userGetLoading(true);
    try {
      QuerySnapshot snapshot =
          await firebaseService.getAllData(collection: 'users');

      users.value = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return UserProfileModel.fromMap(data);
      }).toList();
      userGetLoading(false);
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  review(
      {required String senderId,
      receverId,
      description,
      reviewerName,
      rating,
      feeling,
      talkTime}) async {
    var body = {
      "description": "$description",
      "reviewName": "$reviewerName",
      "rating": "$rating",
      "feeling": "$feeling",
      "reviewId": "$senderId",
      "time": DateTime.now().toString()
    };
    firebaseService.appendReviewToList("$receverId", body,
        collectionName: "reviews");

    // Get the current user data
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(receverId)
        .get();
    if (userDoc.exists) {
      var userData = userDoc.data() as Map<String, dynamic>;

      // Calculate updated values
      int totalTalkTime = (userData['total_talk_time'] as String).isEmpty ? 0 : int.parse(userData['total_talk_time']) + int.parse(talkTime);
      int totalReview = (userData['total_review'] as String).isEmpty ? 0 : int.parse(userData['total_review']);
      int totalCall = (userData['total_call'] as String).isEmpty ? 0 : int.parse(userData['total_call']);

      var updatedBody = {
        "total_talk_time": totalTalkTime.toString(),
        "total_review": (totalReview + 1).toString(),
        "total_call": (totalCall + 1).toString(),
      };

      // Update user data in Firestore
      await firebaseService.updateData(
        userId: receverId,
        collection: "users",
        updatedData: updatedBody,
      );
    }

    Get.offNamed(AppRoutes.homeScreen);
  }

  RxInt availeGenderSelectedIndex = 0.obs;
  RxList availeGenderList = [
    {'title': 'any', 'icon': AppIcons.manWoman},
    {'title': 'girl', 'icon': AppIcons.girl},
    {'title': 'boy', 'icon': AppIcons.man}
  ].obs;

  var secondsRemaining = 20.obs; // Timer for 20 seconds
  var buttonLabel = "Start Call".obs; // Observable for button label
  late Timer _timer;
  var isCalling = false.obs; // Track call state

  @override
  void onInit() {
    super.onInit();
    buttonLabel.value = "Start Call"; // Initial button label
  }

  void startTimer() {
    if (!isCalling.value) {
      // Start the call
      isCalling.value = true;
      buttonLabel.value = "Calling"; // Change button label to "Calling"

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (secondsRemaining.value > 0) {
          secondsRemaining.value--;
        } else {
          buttonLabel.value = "Start Call"; // Reset button label
          isCalling.value = false; // Reset call state
          secondsRemaining.value = 20; // Reset the timer
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
