import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk/services/firebase_services.dart';
import 'package:free_talk/utils/app_images.dart';
import 'package:free_talk/views/base/custom_botton.dart';
import 'package:get/get.dart';

import '../../../helpers/prefs_helper.dart';
import '../../../utils/app_constants.dart';
import '../../base/custom_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? selectedAvatarUrl;
  var data = Get.arguments;

  @override
  void initState() {
    setState(() {
      selectedAvatarUrl = data["image"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Select Avatar',
          style: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top Image Display
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    border: Border.all(color: Colors.greenAccent, width: 0.5),
                    imageUrl: selectedAvatarUrl != null
                        ? selectedAvatarUrl.toString()
                        : data['gender'] == "Male"
                            ? AppImages.maleAvatars.first
                            : AppImages.femaleAvatars.first,
                    height: 150.h,
                    width: 150.w)),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select',
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: data['gender'] == "Male"
                    ? AppImages.maleAvatars.length
                    : AppImages.femaleAvatars.length,
                itemBuilder: (context, index) {
                  final avatarUrl = data['gender'] == "Male"
                      ? AppImages.maleAvatars[index]
                      : AppImages.femaleAvatars[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatarUrl = avatarUrl;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedAvatarUrl == avatarUrl
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Save Profile Button

            CustomBotton(
                title: "Save Avatar",
                onpress: () async {
                  FirebaseService firebase = FirebaseService();
                  var body = {"image": selectedAvatarUrl.toString()};
                  firebase.updateData(
                      userId: "${data["id"].toString()}",
                      collection: "users",
                      updatedData: body);
                  await PrefsHelper.setString(AppConstants.image, selectedAvatarUrl.toString());
                })
          ],
        ),
      ),
    );
  }
}
