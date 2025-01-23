import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/login.dart';
import 'package:gym_kid/views/auth/signup/signup.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../res/colors.dart';
import '../../res/dimens.dart';
import '../../res/styles.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      body: BackgroundImage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 400),
            slidingBeginOffset: const Offset(0, 1),
              child: Lottie.asset(
                Get.isDarkMode
                    ? "assets/animations/intro.json"
                    : "assets/animations/intro.json",
                height: 40.h,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 800),
              slidingBeginOffset: const Offset(1, 0),
              child: Padding(
                  padding: PAD_SYM_H20,
                  child: Text(
                    "Reflect on your practice today",
                    textAlign: TextAlign.center,
                    style: boldStyle.copyWith(
                      color: Get.isDarkMode ? AppColors.fontColor : Colors.white, fontSize: 36
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: PAD_SYM_H10,
                child: DelayedDisplay(
                  slidingBeginOffset: Offset(-1, 0),
                  delay: Duration(milliseconds: 800),
        
                  child: SubHeadingText(
                      text:
                          "Gym Kid is your safe space to express and navigate your feelings after each practice, helping you and your parents understand your journey within your sport."),
                )),
            const SizedBox(
              height: 40,
            ),
            DelayedDisplay(
              slidingBeginOffset: const Offset(-10, 0),
              delay: const Duration(seconds:2),
              child: CustomButton.commonButton(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const Login()));
                  },
                  buttonText: 'Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
