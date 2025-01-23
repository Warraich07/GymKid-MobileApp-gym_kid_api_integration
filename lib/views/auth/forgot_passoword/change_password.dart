import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/common_widget.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/login.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../res/dimens.dart';
import '../components/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool passwordVisible = true;
  bool confirmPassVisible = true;
  final AuthController _authController=Get.find();

  final confirmPasswordController=TextEditingController();
  final passwordController=TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        // backgroundColor:
        //     Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: PAD_SYM_H20,
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CommonWidget.backbutton()),
                  const SizedBox(
                    height: 20,
                  ),
                  const HeadingText(text: 'Reset Password'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SubHeadingText(
                      text: 'Create a new password for your Account'),
                  SizedBox(
                    height: 10.h,
                  ),
                  const SubHeadingText(text: 'Password'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField.authInputFields(
      
                      validator: (value) => CustomValidator.password(value),
                      textEditingController: passwordController,
                      hint: "Password",
                      obscureText: passwordVisible,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_rounded,
                            color: Get.isDarkMode
                                ? AppColors.placeholderColor
                                : AppColors.placeholderColor,
                          ),
                        ),
                      ),
                      prefixIcon: Image.asset(
                        'assets/icons/password.png',
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.6)
                            : Colors.white.withOpacity(0.6),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  const SubHeadingText(text: 'Confirm Password'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField.authInputFields(
      
                      validator: (value) => CustomValidator.confirmPassword(value,passwordController.text.toString()),
      
                      textEditingController: confirmPasswordController,
                      hint: "Confirm Password",
                      obscureText: confirmPassVisible,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              confirmPassVisible = !confirmPassVisible;
                            });
                          },
                          child: Icon(
                            confirmPassVisible
                                ? Icons.visibility
                                : Icons.visibility_off_rounded,
                            color: Get.isDarkMode
                                ? AppColors.placeholderColor
                                : AppColors.placeholderColor,
                          ),
                        ),
                      ),
                      prefixIcon: Image.asset(
                        'assets/icons/password.png',
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.6)
                            : Colors.white.withOpacity(0.6),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(-10, 0),
                    delay: const Duration(milliseconds:100),
                    child: CustomButton.commonButton(
                        onTap: () {
                          if(_key.currentState!.validate()){
                            print("object");
                            _authController.changePassword(passwordController.text.toString(), confirmPasswordController.text.toString());
                          }
                          // Get.offAll(() => Login());
                        },
                        buttonText: 'Save Password'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
