import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/images.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';

import '../../components/page_navigation.dart';
import '../../controllers/auth_controller.dart';
import '../../helper/shared_preference.dart';
import '../../models/main_user_model.dart';
import '../../res/dimens.dart';
import '../../res/loading.dart';
import '../navbar/bottom_nav_bar.dart';
import 'intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AuthController _authController=Get.find();
  checkUserLogIn() async {
    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
    bool isLoggedIn = userStatus["isLoggedIn"];
    if(isLoggedIn==true){
      _authController.accessToken.value =
      await AuthPreference.instance.getUserDataToken();
      print(await AuthPreference.instance.getUserData());
      String result = await AuthPreference.instance.getUserData();
      Map<String,dynamic> userMap = jsonDecode(result) as Map<String, dynamic>;
      _authController.userData.value = MainUserModel.fromJson( userMap);
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CustomBottomNavBar())));
      // PageTransition.pageProperNavigation(page: CustomBottomNavBar());
    }else{
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Intro())));
    }


    /* bool checkLogIn = await getUserLoggedIn();
    if (checkLogIn) {
      _authController.token.value = await getUserDataToken();
      log(_authController.token.value);
      await _authController.getUserData();
      Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CustomBottomNavBar())));
    } else {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    } */
  }

  @override
  void initState() {
    checkUserLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.isDarkMode
      //     ? AppColors.backgroundColor
      //     : AppColors.lightBackgroundColor,
      body: BackgroundImage(
        child: Padding(
          padding: PAD_ALL_80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4C000000),
                      blurRadius: 18,
                      offset: Offset(0, 0),
                      spreadRadius: -2,
                    )
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.splashImage,
                    height: 218,
                    width: 210,
                  ),
                ),
              ),
              spinkit
            ],
          ),
        ),
      ),
    );
  }
}
