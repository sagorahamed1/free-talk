import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_talk/helpers/toast_message_helper.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../firebase_options.dart';
import '../utils/Config.dart';


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
    } catch (e) {
      debugPrint("Sign-in Error: $e");
      return null;
    }
  }

  ///=====Sign Out====>
   Future<void> signOut() async {
    await _auth.signOut();
  }

  ///=======Store Data======>
   Future<void> postData(String userId, Map<String, dynamic> data) async {
    try {
      await fireStore.collection('users').doc(userId).set(data);
    } catch (e) {
      debugPrint("Save Data Error: $e");
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



  Future<void> startGroupCall(BuildContext context, String currentUserId) async {
    // Fetch the latest room ID from Firestore
    debugPrint('Fetching the latest room ID...');
    QuerySnapshot roomQuery = await fireStore.collection('rooms')
        .orderBy('roomId', descending: true)
        .limit(1)
        .get();

    String newRoomId;
    int userCount;

    if (roomQuery.docs.isNotEmpty) {
      var latestRoom = roomQuery.docs.first;
      newRoomId = latestRoom['roomId'];
      userCount = latestRoom['userCount'];

      debugPrint('Latest room ID: $newRoomId with $userCount user(s)');

      // If the room is full (2 users), create a new room
      if (userCount >= 2) {
        newRoomId = (int.parse(newRoomId) + 1).toString();
        userCount = 0;
        debugPrint('Room is full. Creating a new room with ID: $newRoomId');
      } else {
        debugPrint('Adding to the existing room with ID: $newRoomId');
      }
    } else {
      // Start with roomId 1 if no rooms exist
      newRoomId = '1';
      userCount = 0;
      debugPrint('No rooms found. Starting with room ID: $newRoomId');
    }

    // Update room data
    await fireStore.collection('rooms').doc(newRoomId).set({
      'roomId': newRoomId,
      'userCount': userCount + 1,
    });

    debugPrint('Updated room ID: $newRoomId with ${userCount + 1} user(s)');

    // Only start the call if the room has 2 users
    if (userCount + 1 == 2) {
      debugPrint('Room is ready. Starting call in room $newRoomId');

      // Navigate to the call screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ZegoUIKitPrebuiltCall(
            appID: Config.appId,
            appSign: Config.appSign,
            userID: currentUserId,  // Use currectUser as userID
            userName: currentUserId, // Use currectUser as userName
            plugins: [ZegoUIKitSignalingPlugin()],
            callID: newRoomId,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
          ),
        ),
      );
    } else {
      debugPrint('Waiting for more users to join room $newRoomId');
      // Optional: Show a waiting message or UI
    }
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
  //   // Proceed with starting the group call
  //   debugPrint('Starting call in room $newRoomId');
  //
  //   // Navigate to the call screen
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => ZegoUIKitPrebuiltCall(
  //         appID: Config.appId,
  //         appSign: Config.appSign,
  //         userID: userName,
  //         userName: userName,
  //         plugins: [ZegoUIKitSignalingPlugin()],
  //         callID: newRoomId,
  //         config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
  //       ),
  //     ),
  //   );
  // }


}



// void startGroupCall(BuildContext context, String roomId, String userName) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => ZegoUIKitPrebuiltCall(
//         appID: Config.appId,
//         appSign: Config.appSign,
//         userID: userName,
//         userName: 'userName',
//         plugins: [ZegoUIKitSignalingPlugin()], callID: roomId, config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
//       ),
//     ),
//   );
// }