import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/colors.dart';

const normalStyle = TextStyle(
  fontSize: 14,
);

const titleStyle = TextStyle(
  fontSize: 35,
);

TextStyle boldStyle = TextStyle(
  color: Get.isDarkMode ? AppColors.fontColor : Colors.black,
  fontSize: 30,
  fontFamily: 'Poppins-Medium',
  fontWeight: FontWeight.w500,
  height: 1.1,
);

TextStyle subHeadingStyle = TextStyle(
  color: Get.isDarkMode
      ? Colors.white.withOpacity(0.6)
      : Colors.black.withOpacity(0.6),
  fontSize: 15,
  fontFamily: 'Poppins-Medium',
  fontWeight: FontWeight.w500,
  height: 1.1,
);
TextStyle smallTextStyle = TextStyle(
  color: Get.isDarkMode ? AppColors.secondaryFontColor : Colors.black,
  fontSize: 13,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
);

TextStyle hintStyle = TextStyle(
  color: Get.isDarkMode
      ? AppColors.secondaryFontColor.withOpacity(0.6)
      : AppColors.secondaryFontColor.withOpacity(0.6),
  fontSize: 15,
  fontFamily: 'Poppins-Medium',
  fontWeight: FontWeight.w500,
  height: 1.1,
);
TextStyle headingHomeStyle = TextStyle(
  color: Get.isDarkMode ? Colors.white :  Colors.white,
  fontSize: 20,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
);

const errorStyle = TextStyle(
  fontSize: 14,
  color: Colors.red,
);

const smallHintStyle = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  color: Colors.grey,
);

class AppStyles {
  static TextStyle style25 = TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.black,
    fontSize: 25,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );
  static TextStyle style20 = TextStyle(
    color: Get.isDarkMode ? Colors.white : Colors.white,
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );
}
