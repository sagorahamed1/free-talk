import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static UserModel? _currentUser;

  static UserModel get currentUser {
    if (_currentUser == null) {
      throw Exception('_current user model must not be null when calling this getter');
    }
    return _currentUser!;
  }

  static Future<void> setUpFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
      fireStore.collection('user').snapshots();

  Future<bool> signUp({
    required String name,
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final UserModel user = UserModel(email: email, userName: userName, name: name);

      print("======================sign up done");
      if (cred.user != null) {
        final docRef = fireStore.collection('user').doc(cred.user!.uid);
        print("======================firestore done");
        final doc = await docRef.get();
        if (doc.exists) {
          return false;
        }
        await docRef.set(user.toJson());
        _currentUser = user;  // Set the current user
        return true;
      }
      return false;
    } catch (e) {
      print("-------error $e");
      return false;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      final docRef = fireStore.collection('user').doc(userCredential.user!.uid);
      final doc = await docRef.get();

      if (doc.exists) {
        _currentUser = UserModel.fromJson(doc.data()!);
      }

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
  }
}

class UserModel {
  final String email;
  final String userName;
  final String name;

  const UserModel({
    required this.userName,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userName: json['userName'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'userName': userName
  };
}