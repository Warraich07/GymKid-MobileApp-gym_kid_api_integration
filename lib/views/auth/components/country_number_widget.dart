import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../res/colors.dart';

class CountryCodePicker extends StatefulWidget {
  TextEditingController phoneController;

  CountryCodePicker({super.key, required this.phoneController});

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  String _countryCode = '';
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        if (widget.phoneController.text.isNotEmpty &&
            widget.phoneController.text.startsWith('0')) {
          print('_PHONECONTROLLER: ${widget.phoneController.text}');
          widget.phoneController.clear();
          setState(() {});
          return;
        }

        setState(() {
          _countryCode = number.dialCode.toString();
        });
      },
      onInputValidated: (bool value) {},
      selectorConfig: const SelectorConfig(
        leadingPadding: 18,
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
      ),
      ignoreBlank: true,
      autoValidateMode: AutovalidateMode.always,
      selectorTextStyle: const TextStyle(color: Colors.black),
      hintText: 'Phone Number',
      initialValue: number,
      inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 20, minHeight: 20, minWidth: 60),
          fillColor: AppColors.primaryColor.withOpacity(0.12),
          filled: true,
          border: InputBorder.none,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border transparent
              width: 0, // Set the width to 0 to make it disappear
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border transparent
              width: 0, // Set the width to 0 to make it disappear
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border transparent
              width: 0, // Set the width to 0 to make it disappear
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border transparent
              width: 0, // Set the width to 0 to make it disappear
            ),
          ),
          hintText: 'Phone Number',
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
            fontFamily: 'Poppins',
          )),
      textStyle: const TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      spaceBetweenSelectorAndTextField: 0,
      // validator: (String? value) => CustomValidator.number(value),
      textFieldController: widget.phoneController,
      formatInput: true,
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: false),
      inputBorder: InputBorder.none,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
