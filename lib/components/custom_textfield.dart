import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool isHint;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isObscure;
  final bool? isReadOnly;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField(
      {Key? key,
      this.isHint = true,
      this.hintText,
      this.suffixIcon,
      this.isObscure,
      this.controller,
      this.prefixIcon,
      this.isReadOnly,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.sentences,
      this.validator})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.isObscure ?? false,
      controller: widget.controller,
      readOnly: widget.isReadOnly ?? false,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: AppColors.yellowColor,
        fontSize: 15,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        fillColor: Get.isDarkMode ? AppColors.textfieldColor : AppColors.textfieldColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
        hintStyle: TextStyle(
          color: AppColors.unSelectedColor,
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        border: InputBorder.none,
        // disabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(40.0),
        //   borderSide: BorderSide(
        //     color: Get.isDarkMode
        //         ? Colors.transparent
        //         : Colors.grey, // Make the border transparent
        //     width: 0, // Set the width to 0 to make it disappear
        //   ),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode
                ? Colors.transparent
                : Colors.transparent, // Make the border transparent
            width: 0, // Set the width to 0 to make it disappear
          ),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(40.0),
        //   borderSide: const BorderSide(
        //     color: Colors.transparent, // Make the border transparent
        //     width: 0, // Set the width to 0 to make it disappear
        //   ),
        // ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(
            color: Get.isDarkMode
                ? Colors.transparent
                : Colors.grey, // Make the border transparent
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
        hintText: widget.isHint ? widget.hintText : null,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: Colors.white.withOpacity(0.4),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: Colors.black54,
        suffixIconConstraints:
            const BoxConstraints(minWidth: 20, maxHeight: 20),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 20, maxHeight: 20),
      ),
    );
  }
}
