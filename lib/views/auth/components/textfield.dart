/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:sizer/sizer.dart';

import '../../../res/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isObscure;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      this.isObscure,
      this.prefixIcon,
      this.keyboardType,
      this.inputFormatters,
      required this.controller,
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
    return Center(
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        obscureText: widget.isObscure ?? false,
        controller: widget.controller,
        cursorColor: fontColor,
        style: subHeadingStyle,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            fillColor: textfieldColor,
            filled: true,

            // contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            hintText: widget.hintText,
            hintStyle: hintStyle,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: Colors.black,
            prefixIcon: widget.prefixIcon,
            prefixIconColor: Colors.white,
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 30,
              minHeight: 30,
            )),
      ),
    );
  }
}
 */