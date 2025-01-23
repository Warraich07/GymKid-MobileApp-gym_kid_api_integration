import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/res/colors.dart';

class CommonWidget {
  static Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back,
        color: Get.isDarkMode ? Colors.white : Colors.white,
      ),
    );
  }
}

class GenderDropdown extends StatefulWidget {
  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Get.isDarkMode ? AppColors.textfieldColor :AppColors.textfieldColor,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        hintText: '  Gender',
        hintStyle: TextStyle(
          color: Colors.yellow,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode ? Colors.transparent : Colors.transparent,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode ? Colors.transparent : Colors.transparent,
            width: 0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode
                ? Colors.transparent
                : Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode
                ? Colors.transparent
                : Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
      ),
      value: selectedGender,
      onChanged: (newValue) {
        setState(() {
          selectedGender = newValue;
        });
      },
      items: <String>['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: AppColors.yellowColor,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
