import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_talk/helpers/toast_message_helper.dart';
import 'package:free_talk/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../firebase_options.dart';
import '../utils/Config.dart';
import '../views/screens/review/review_screen.dart';


class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///======Firebase Initialization=======>
  static Future<void> setUpFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  ///=====Sign Up=====>
   Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('===> ${userCredential.user}');
      return userCredential.user;
    } catch (e) {
      debugPrint("Registration Error: $e");
      return null;
    }
  }


  ///======Log In======>
   Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        ToastMessageHelper.showToastMessage('User not found!');
      }else if(e.code == "wrong-password"){
        ToastMessageHelper.showToastMessage('Your Password is Wrong!');
      }
    }
    // catch (e,s) {
    //   debugPrint("Sign-in Error: $e");
    //   debugPrint("Sign-in Error s: $s");
    //   return null;
    // }
  }

  ///=====Sign Out====>
   Future<void> signOut() async {
    await _auth.signOut();
  }

  ///=======Store Data======>
   Future<void> postData(String userId, Map<String, dynamic> data, {String? collectionName}) async {
    try {
      await fireStore.collection(collectionName ?? 'users').doc(userId).set(data);
    } catch (e) {
      debugPrint("Save Data Error: $e");
    }
  }




  /// Store Data: Update list in Firestore
  Future<void> appendReviewToList(String userId, Map<String, dynamic> newReview, {String? collectionName}) async {
    try {
      DocumentReference docRef = fireStore.collection(collectionName ?? 'reviews').doc(userId);

      await fireStore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          // If no document exists, create it with an initial review list
          transaction.set(docRef, {
            'reviewsList': [newReview],
          });
        } else {
          // Append new review to the existing list
          List<dynamic> reviewsList = snapshot.get('reviewsList') as List<dynamic>;
          reviewsList.add(newReview);
          transaction.update(docRef, {'reviewsList': reviewsList});
        }
      });
    } catch (e) {
      debugPrint("Error saving review to list: $e");
    }
  }



  ///==========Get Data======>
   Future<DocumentSnapshot> getData({required String id,required String collection }) async {
    try {
      return await fireStore.collection(collection).doc(id).get();
    } catch (e) {
      debugPrint("Get Data Error: $e");
      rethrow;
    }
  }


  ///========== Get All Data ======>
  Future<QuerySnapshot> getAllData({required String collection}) async {
    try {
      return await fireStore.collection(collection).get();
    } catch (e) {
      debugPrint("Get Data Error: $e");
      rethrow;
    }
  }

  ///=======Update Data======>
   Future<void> updateData(
      {required String userId,required String collection, required Map<String, dynamic> updatedData}) async {
    try {
      await fireStore.collection(collection).doc(userId).update(updatedData);
      debugPrint('Data updated successfully!');
    } catch (e) {
      debugPrint("Update Data Error: $e");
    }
  }


  ///=======Delete Data======>
   Future<void> deleteData({required String userId,required String collection}) async {
    try {
      await fireStore.collection(collection).doc(userId).delete();
      debugPrint('Data deleted successfully!');
    } catch (e) {
      debugPrint("Delete Data Error: $e");
    }
  }


  ///=====Forgot Password=====>
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent to $email');
    } catch (e) {
      debugPrint("Forgot Password Error: $e");
    }
  }



  ///=====Change Password with Old Password Verification=====>
  Future<void> changePassword(String email, String oldPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Re-authenticate the user with the old password
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: oldPassword,
        );

        // Re-authenticate the user
        await user.reauthenticateWithCredential(credential);

        // After successful re-authentication, update the password
        await user.updatePassword(newPassword);
        ToastMessageHelper.showToastMessage("Password changed successfully!");
        debugPrint('Password changed successfully!');
      } else {
        debugPrint("No user is currently signed in.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Change Password Error: $e");
      debugPrint("Change Password Error: $e");
    }
  }




  Future<void> startGroupCall(BuildContext context, String currentUserId, name) async {
    // Fetch the latest room ID from Firestore
    debugPrint('Fetching the latest room ID...');
    QuerySnapshot roomQuery = await fireStore
        .collection('rooms')
        .orderBy('roomId', descending: true)
        .limit(1)
        .get();

    String newRoomId;
    int userCount;
    List<String> userIds = [];

    if (roomQuery.docs.isNotEmpty) {
      var latestRoom = roomQuery.docs.first;
      newRoomId = latestRoom['roomId'];
      userCount = latestRoom['userCount'];
      userIds = List<String>.from(latestRoom['userIds'] ?? []);

      debugPrint('Latest room ID: $newRoomId with $userCount user(s)');

      // If the room is full (2 users), create a new room
      if (userCount >= 2) {
        newRoomId = (int.parse(newRoomId) + 1).toString();
        userCount = 0;
        userIds = [];
        debugPrint('Room is full. Creating a new room with ID: $newRoomId');
      } else {
        debugPrint('Adding to the existing room with ID: $newRoomId');
      }
    } else {
      // Start with roomId 1 if no rooms exist
      newRoomId = '1';
      userCount = 0;
      userIds = [];
      debugPrint('No rooms found. Starting with room ID: $newRoomId');
    }

    // Add currentUserId to the list of userIds if it's not already present
    if (!userIds.contains(currentUserId)) {
      userIds.add(currentUserId);
    }

    // Update room data with the current user
    DocumentReference roomDoc = fireStore.collection('rooms').doc(newRoomId);
    await roomDoc.set({
      'roomId': newRoomId,
      'userCount': userCount + 1,
      'isActive': true, // Mark the room as active
      'userIds': userIds, // Save the list of user IDs
    }, SetOptions(merge: true));

    debugPrint('Updated room ID: $newRoomId with ${userCount + 1} user(s)');

    // Listen to changes in the room's userCount in real-time
    roomDoc.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        int updatedUserCount = snapshot['userCount'];
        bool isActive = snapshot['isActive'] ?? true;
        List<String> fetchedUserIds = List<String>.from(snapshot['userIds'] ?? []);

        debugPrint('Real-time update: Room $newRoomId has $updatedUserCount user(s)');
        debugPrint('Fetched User IDs: $fetchedUserIds');

        // Determine sender and receiver based on currentUserId
        String senderId = '';
        String receiverId = '';

        if (fetchedUserIds.isNotEmpty) {
          for (var userId in fetchedUserIds) {
            if (userId == currentUserId) {
              senderId = userId;
            } else {
              receiverId = userId;
            }
          }
        }

        // Handle call when 2 users are present and room is active
        if (updatedUserCount == 2 && isActive) {
          debugPrint('Room is ready. Starting call in room $newRoomId');
          debugPrint('Sender ID: $senderId, Receiver ID: $receiverId');

          // Navigate to the call screen for a 2-person group call
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ZegoUIKitPrebuiltCall(
                appID: Config.appId,
                appSign: Config.appSign,
                userID: currentUserId,
                userName: currentUserId,
                plugins: [ZegoUIKitSignalingPlugin()],
                callID: newRoomId,
                config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
                onDispose: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Get.toNamed(AppRoutes.reviewScreen, arguments: {
                      'senderId': senderId,
                      'receiverId': receiverId,
                      'name' : name
                    });
                  });
                },
              ),
            ),
          );
        }
        // Handle the case where a user leaves the room
        else if (updatedUserCount < 2 && isActive) {
          debugPrint('One user left the room $newRoomId. Waiting for another user to join.');
        }
      }
    });
  }




//
  // ///========== Room ID and Group Call Handling ==========>
  // Future<void> startGroupCall(BuildContext context, String userName) async {
  //   // Fetch the latest room ID from Firestore
  //   debugPrint('Fetching the latest room ID...');
  //   QuerySnapshot roomQuery = await fireStore.collection('rooms')
  //       .orderBy('roomId', descending: true)
  //       .limit(1)
  //       .get();
  //
  //   String newRoomId;
  //   int userCount;
  //
  //   if (roomQuery.docs.isNotEmpty) {
  //     var latestRoom = roomQuery.docs.first;
  //     newRoomId = latestRoom['roomId'];
  //     userCount = latestRoom['userCount'];
  //
  //     debugPrint('Latest room ID: $newRoomId with $userCount user(s)');
  //
  //     // If the room is full (2 users), create a new room
  //     if (userCount >= 2) {
  //       newRoomId = (int.parse(newRoomId) + 1).toString();
  //       userCount = 0;
  //       debugPrint('Room is full. Creating a new room with ID: $newRoomId');
  //     } else {
  //       debugPrint('Adding to the existing room with ID: $newRoomId');
  //     }
  //   } else {
  //     // Start with roomId 1 if no rooms exist
  //     newRoomId = '1';
  //     userCount = 0;
  //     debugPrint('No rooms found. Starting with room ID: $newRoomId');
  //   }
  //
  //   // Update room data
  //   await fireStore.collection('rooms').doc(newRoomId).set({
  //     'roomId': newRoomId,
  //     'userCount': userCount + 1,
  //   });
  //
  //   debugPrint('Updated room ID: $newRoomId with ${userCount + 1} user(s)');
  //
  //   // Only start the call if the room has 2 users
  //   if (userCount + 1 == 2) {
  //     debugPrint('Room is ready. Starting call in room $newRoomId');
  //
  //     // Navigate to the call screen
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => ZegoUIKitPrebuiltCall(
  //           appID: Config.appId,
  //           appSign: Config.appSign,
  //           userID: userName,
  //           userName: userName,
  //           plugins: [ZegoUIKitSignalingPlugin()],
  //           callID: newRoomId,
  //           config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
  //         ),
  //       ),
  //     );
  //   } else {
  //     debugPrint('Waiting for more users to join room $newRoomId');
  //     // Optional: Show a waiting message or UI
  //   }
  // }







}






class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
