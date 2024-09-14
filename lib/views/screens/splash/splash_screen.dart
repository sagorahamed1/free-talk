

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:free_talk/helpers/prefs_helper.dart';
import 'package:free_talk/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async{

      bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
      if(isLogged){
        Get.offAllNamed(AppRoutes.homeScreen);
      }else{
        Get.offAllNamed(AppRoutes.logInScreen);
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///========logo======

            SizedBox(
                child: Image.asset('assets/images/logo.png')),
          ],
        ),
      ),
    );
  }
}
