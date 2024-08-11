import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../base/custom_botton.dart';
import '../../base/custom_text.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController dateOfBirthCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final profileData = Get.arguments;

  Uint8List? _image;
  File? selectedImage;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  CustomText(text: 'Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(),
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: "Change Profile Picture",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  top: 12.h,
                  bottom: 24.h,
                ),
              ),
              _textField("Enter your first name", AppIcons.flag, firstNameCtrl, TextInputType.text),
              _textField("Enter your last name", AppIcons.flag, lastNameCtrl, TextInputType.text),
              _textField("+ 8845632140", AppIcons.flag, phoneCtrl, TextInputType.phone),
              _textField("Enter your date of birth", AppIcons.flag, dateOfBirthCtrl, TextInputType.datetime),
              _textField("Address", AppIcons.flag, addressCtrl, TextInputType.text),
              SizedBox(height: 20.h),
              CustomBotton(
                onpress : () {

                },
                title: "Update Profile"
              ),
              SizedBox(height: 250.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 200.h,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundImage: _image != null
                  ? MemoryImage(_image!)
                  : '' != null
                  ? NetworkImage('')
                  : AssetImage('assets/default_profile.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => showImagePickerOption(context),
                child: SvgPicture.asset(AppIcons.flag),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(String hintText, String prefixIcon, TextEditingController controller, TextInputType type) {
    return Column(
      children: [
        TextFormField(
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                prefixIcon,
                color: AppColors.primaryColor,
                height: 20.h,
                width: 20.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickImageFromGallery,
                    child: Column(
                      children: [
                        Icon(Icons.image, size: 50.w),
                         CustomText(text: 'Gallery'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: _pickImageFromCamera,
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt, size: 50.w),
                         CustomText(text: 'Camera'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        _image = selectedImage!.readAsBytesSync();
      });
      Get.back();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        _image = selectedImage!.readAsBytesSync();
      });
      Get.back();
    }
  }
}
