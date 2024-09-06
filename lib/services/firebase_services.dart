import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_talk/helpers/toast_message_helper.dart';
import '../firebase_options.dart';


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



  // ///=====Change Password=====>
  // Future<void> changePassword(String newPassword) async {
  //   try {
  //     User? user = _auth.currentUser;
  //     if (user != null) {
  //       await user.updatePassword(newPassword);
  //       ToastMessageHelper.showToastMessage("Password changed successfully!");
  //       debugPrint('Password changed successfully!');
  //     } else {
  //       debugPrint("No user is currently signed in.");
  //     }
  //   } catch (e) {
  //     debugPrint("Change Password Error: $e");
  //   }
  // }



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

}
