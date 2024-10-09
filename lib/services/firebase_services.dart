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

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';




class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///======Firebase Initialization=======>
  static Future<void> setUpFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  //
  // ///==============google sign in================>
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  ///====================facebook sign out================>
  static Future<void> signOutFromFacebook() async {
    try {
      // Facebook সাইন আউট
      await FacebookAuth.instance.logOut();

      // Firebase থেকে সাইন আউট
      await FirebaseAuth.instance.signOut();

      print("Successfully signed out from Facebook and Firebase.");
    } catch (e) {
      print("Error during sign out: $e");
    }
  }


  ///====================facebook sign in================>
  static Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // If the login was successful
      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential("${loginResult.accessToken?.tokenString}");

        // Try signing in to Firebase with the Facebook credential
        UserCredential userCredential;
        try {
          userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
          print('User signed in: ${userCredential.user?.email}');
          return userCredential;
        } on FirebaseAuthException catch (e) {
          // If the account already exists with different credential
          if (e.code == 'account-exists-with-different-credential') {
            final List<String> userSignInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(e.email!);

            // You can now prompt the user to use the correct sign-in method
            print('The user has already signed in with one of the following methods: $userSignInMethods');
          }
          throw e;
        }
      } else {
        print("Facebook login failed: ${loginResult.message}");
        return null;
      }
    } catch (e) {
      print("Error during Facebook sign-in: $e");
      return null;
    }
  }


  ///=====Sign Up=====>
   Future<User?> registerWithEmailPassword(String email, String password) async {
     try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password,
       );
       debugPrint('===> ${userCredential.user}');
       return userCredential.user;
     } on FirebaseAuthException catch (e) {
       if (e.code == 'email-already-in-use') {
         ToastMessageHelper.showToastMessage('The email address is already in use by another account.');
         debugPrint("The email address is already in use by another account.");
         // You can show a message to the user here
       } else {
         debugPrint("Registration Error: $e");
       }
       return null;
     } catch (e) {
       debugPrint("Registration Error: $e");
       return null;
     }
  }



  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastMessageHelper.showToastMessage('User not found!');
      } else if (e.code == 'wrong-password') {
        ToastMessageHelper.showToastMessage('Incorrect password!');
      } else {
        ToastMessageHelper.showToastMessage('User not found! $e');
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage('An unexpected error occurred: $e');
    }
    return null;
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




  Future<void> startGroupCall(BuildContext context, String currentUserId, String name, String image) async {
    const int roomIdLength = 6; // Define the desired length of roomId with leading zeros
    DateTime? callStartTime;


    // Function to format roomId with leading zeros
    String formatRoomId(int roomId) {
      return roomId.toString().padLeft(roomIdLength, '0');
    }

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

      try {
        newRoomId = latestRoom['roomId'];
        // Convert the roomId from string to integer and format it
        int parsedRoomId = int.tryParse(newRoomId) ?? 0;
        newRoomId = formatRoomId(parsedRoomId);
      } catch (e) {
        newRoomId = formatRoomId(1);  // Default roomId if there's an error
        debugPrint('Error parsing roomId: $e');
      }

      userCount = latestRoom['userCount'];
      userIds = List<String>.from(latestRoom['userIds'] ?? []);

      debugPrint('*************************************Latest room ID: $newRoomId with $userCount user(s)');

      // If the room is full (2 users), create a new room
      if (userCount >= 2) {
        int nextRoomId = int.parse(newRoomId) + 1;
        newRoomId = formatRoomId(nextRoomId);
        userCount = 0;
        userIds = [];
        debugPrint('Room is full. Creating a new room with ID: $newRoomId');
      } else {
        debugPrint('Adding to the existing room with ID: $newRoomId');
      }
    } else {
      // Start with roomId '000001' if no rooms exist
      newRoomId = formatRoomId(1);
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
            print("**************************************************************users $userId");
            if (userId == currentUserId) {
              senderId = userId;
            } else {
              receiverId = userId;
            }
          }
        }

        // Handle call when 2 users are present and room is active
        if (updatedUserCount == 2 && isActive) {
          callStartTime = DateTime.now();
          debugPrint('Room is ready. Starting call in room $newRoomId');
          debugPrint('Sender ID: $senderId, Receiver ID: $receiverId');


          // Navigate to the call screen for a 2-person group call
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ZegoUIKitPrebuiltCall(
                appID: Config.appId,
                appSign: Config.appSign,
                userID: currentUserId,
                userName: "",
                plugins: [ZegoUIKitSignalingPlugin()],
                callID: newRoomId,
                config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
                  ..avatarBuilder = (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
                    return user != null
                        ? Column(
                          children: [
                            // Avatar Image with 200x200 size
                            Container(
                              height: 80,
                              width: 80,  // Setting width and height to 200
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover,  // Ensures the image fits within the circle
                                ),
                              ),
                            ),

                            // Caller Name Below the Image with Overflow Handling
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,  // Handles name overflow
                                maxLines: 1,  // Restricts to one line
                                textAlign: TextAlign.center,  // Aligns name to center
                              ),
                            ),
                          ],
                        )
                        : const SizedBox();
                  },
                onDispose: () {
                  DateTime callEndTime = DateTime.now();
                  Duration callDuration = callEndTime.difference(callStartTime!);
                  int durationInMinutes = callDuration.inMinutes;
                  Future.delayed(const Duration(milliseconds: 100), () {
                    Get.toNamed(AppRoutes.reviewScreen, arguments: {
                      'senderId': senderId,
                      'receiverId': receiverId,
                      'name' : name,
                      "time" : durationInMinutes
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

}


