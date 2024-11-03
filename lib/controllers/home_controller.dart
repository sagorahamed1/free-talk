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
    // Get.to(const VoiceCallScreen());
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
    // Get.to(const VoiceCallScreen());
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

  review({
    required String senderId,
    required String receiverId,
    required String description,
    required String reviewerName,
    required int rating,
    required String feeling,
    required int talkTime,
  }) async {
    try {
      var body = {
        "description": description,
        "reviewName": reviewerName,
        "rating": rating.toString(),
        "feeling": feeling,
        "reviewId": senderId,
        "time": DateTime.now().toString(),
      };

      await firebaseService.appendReviewToList(receiverId, body, collectionName: "reviews");

      // Get the current user data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(receiverId)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;

        // Safely parse integers from Firestore data
        int totalTalkTime = int.tryParse(userData['total_talk_time'] ?? '0') ?? 0;
        int totalReview = int.tryParse(userData['total_review'] ?? '0') ?? 0;
        int totalCall = int.tryParse(userData['total_call'] ?? '0') ?? 0;

        // Update values with new data
        totalTalkTime += talkTime.toInt();
        totalReview += 1;
        totalCall += 1;

        var updatedBody = {
          "total_talk_time": totalTalkTime.toString(),
          "total_review": totalReview.toString(),
          "total_call": totalCall.toString(),
        };

        // Update user data in Firestore
        await firebaseService.updateData(
          userId: receiverId,
          collection: "users",
          updatedData: updatedBody,
        );
      }

      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      print("Error in review submission: $e");
      // Optionally, show an error message to the user here
    }
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
