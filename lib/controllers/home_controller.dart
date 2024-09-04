import 'package:cloud_firestore/cloud_firestore.dart';
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
  RxString currectUser = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllUsers();
  }

  ///===== Fetch all users data ===>
  Future<void> fetchAllUsers() async {
    userGetLoading(true);
    currectUser.value = await PrefsHelper.getString(AppConstants.currentUser);
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
}
