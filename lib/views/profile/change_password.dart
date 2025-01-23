import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/controllers/auth_controller.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/components/custom_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../constants/custom_validators.dart';
import '../../res/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ChangePassword> {
  // final DataHelper _dataController = Get.find<DataHelper>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  final TextEditingController oldPasswordEditingController =
      TextEditingController();
  final TextEditingController newPasswordEditingController =
      TextEditingController();
  final TextEditingController confirmNewPasswordController =
  TextEditingController();
  final GlobalKey<FormState> resetFormField = GlobalKey();
AuthController _authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: resetFormField,
        child: BackgroundImage(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 15.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    CustomAppBar(
                      pageTitle: " ",
                      onTap: () {
                        Get.back();
                      },
                      leadingButton: Icon(
                        Icons.arrow_back_ios,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Create a new password for your Account",
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                      child: CustomTextField.authInputFields(
                          validator: (value) => CustomValidator.password(value),
                          textEditingController: oldPasswordEditingController,
                          hint: "Old Password",
                          obscureText: _obscureText,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off_rounded,
                                color: AppColors.placeholderColor,
                              ),
                            ),
                          ),
                          prefixIcon: Image.asset(
                            'assets/icons/password.png',
                            color: Get.isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
      
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                      child: CustomTextField.authInputFields(
                          validator: (value) => CustomValidator.password(value),
                          textEditingController: newPasswordEditingController,
                          hint: "New Password",
                          obscureText: _obscureTextConfirm,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  _obscureTextConfirm = !_obscureTextConfirm;
                                });
                              },
                              child: Icon(
                                _obscureTextConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off_rounded,
                                color: AppColors.placeholderColor,
                              ),
                            ),
                          ),
                          prefixIcon: Image.asset(
                            'assets/icons/password.png',
                            color: Get.isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                :Colors.white.withOpacity(0.6),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                      child: CustomTextField.authInputFields(
                          validator: (value) => CustomValidator.confirmPassword(value,newPasswordEditingController.text),
                          textEditingController: confirmNewPasswordController,
                          hint: "Confirm New Password",
                          obscureText: _obscureTextConfirm,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  _obscureTextConfirm = !_obscureTextConfirm;
                                });
                              },
                              child: Icon(
                                _obscureTextConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off_rounded,
                                color: AppColors.placeholderColor,
                              ),
                            ),
                          ),
                          prefixIcon: Image.asset(
                            'assets/icons/password.png',
                            color: Get.isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                :Colors.white.withOpacity(0.6),
                          )),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: DelayedDisplay(
                        slidingBeginOffset: const Offset(-10, 0),
                        delay: const Duration(milliseconds:100),
                        child: CustomButton.commonButton(
                            buttonText: 'Save Changes',
                            onTap: () {
                              if(_key.currentState!.validate()){
                                  _authController.createNewPassword(oldPasswordEditingController.text.toString(), newPasswordEditingController.text.toString(), confirmNewPasswordController.text.toString());
                              }
                              // if (resetFormField.currentState!.validate()) {
                              //   Get.defaultDialog(
                              //       barrierDismissible: false,
                              //       title: "Mood Meter",
                              //       middleText: "",
                              //       content: Column(
                              //         children: [
                              //           Center(
                              //               child: CircularProgressIndicator(
                              //             color: AppColors.primaryColor,
                              //           ))
                              //         ],
                              //       ));
                              //
                              //   /* _dataController.changePassword(
                              //       context,
                              //       passwordEditingController.text,
                              //       newPasswordEditingController.text); */
                              //   setState(() {});
                              // }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
