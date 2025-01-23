import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/page_navigation.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';
import '../views/calendar/calendar.dart';

class Dialogbox {
  static showHappyDialog(BuildContext context,String mood,String emoji) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            backgroundColor:
                Get.isDarkMode ? AppColors.forgroundColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/emoji ($emoji).gif',
                        height: 20.h,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You are on great way. You are feeling $mood today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();

                          // PageTransition.pageNavigation(
                          //     page: const CalenderScreen());
                        },
                        child: Container(
                          width: 196,
                          height: 55,
                          decoration: ShapeDecoration(
                            color: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.08,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showSadDialog(BuildContext context,String mood,String emoji) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            backgroundColor: AppColors.forgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        // 'assets/images/$emoji.png',
                        'assets/icons/emoji ($emoji).gif',
                        height: 20.h,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'It is very sad to see you Feeling $mood today',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // PageTransition.pageNavigation(
                          //     page: const CalenderScreen());
                        },
                        child: Container(
                          width: 196,
                          height: 55,
                          decoration: ShapeDecoration(
                            color: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.08,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
