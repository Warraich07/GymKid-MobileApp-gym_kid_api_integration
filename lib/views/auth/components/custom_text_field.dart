import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/auth_controller.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField {
  static Widget authInputFields({
    required String hint,
    required TextEditingController textEditingController,
    TextInputType? keyboardType,
    List<TextInputFormatter>? keys,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? obscureText,
    FormFieldValidator<String>? validator,
    String? lastText,
    GlobalKey<FormState>? formKey,
    Function(String)? onChanged, // Updated to use Function(String)?
  }) {
    return TextFormField(
      style: hintStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      cursorColor: AppColors.secondaryFontColor.withOpacity(0.6),
      textAlignVertical:obscureText==true? TextAlignVertical.top:TextAlignVertical.center,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      obscuringCharacter: ".",
      inputFormatters: keys ?? [],
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        filled: true,
        fillColor: Get.isDarkMode
            ? AppColors.textfieldColor
            : AppColors.textfieldColor,
        hintStyle: hintStyle,
        hintText: hint,
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: lastText,
        suffixStyle: hintStyle,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15, bottom: 3),
          child: prefixIcon,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 20,
          minHeight: 20,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}


class OtpField extends StatefulWidget {
  const OtpField({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  AuthController _authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      textStyle: TextStyle(
        color: Colors.white, // Ensures text color is white
        fontSize: 30,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      length: 4,
      obscureText: false,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        return null;
      },

      pinTheme: PinTheme(

        borderWidth: 0.0,
        selectedColor: Get.isDarkMode ? Colors.white : Colors.black,
        selectedFillColor: Colors.transparent,  // Make filled color transparent
        activeColor: const Color(0xffE0AD3A),  // Color of the underline when active
        activeFillColor: Colors.transparent,    // Make filled color transparent
        shape: PinCodeFieldShape.underline,      // Use underline shape
        errorBorderColor: Colors.transparent,
        errorBorderWidth: 0.0,
        inactiveColor: Get.isDarkMode
            ? Colors.white.withOpacity(0.5)
            : Colors.black.withOpacity(0.5),
        inactiveFillColor: Colors.transparent,  // Make filled color transparent
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 55,
        fieldWidth: 50,
      ),
      cursorColor: Get.isDarkMode ? Colors.white : Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        _authController.saveOtp(v.toString());
        print(v.toString());
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          _authController.saveOtp(value.toString());
          print(value.toString());
        setState(() {

        });
          // setState(() {
          //   currentText = value;
          //   error = "";
          //   hasError = false;
          // });
        }
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        return true;
      },
    )
    ;
  }
}
