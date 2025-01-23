import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/helper/custom_dialogbox.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/login.dart';
import 'package:gym_kid/views/auth/signup/reason.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import '../components/custom_text_field.dart';
import '../components/profile_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisible = true;

 final userNameController=TextEditingController();
 final emailController=TextEditingController();
 final passwordController=TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthController _authController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      body: BackgroundImage(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: PAD_SYM_H20,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(0, 0),
                    delay: const Duration(milliseconds:200),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Image.asset(
                            "assets/images/signup.png",
                            height: 10.h,
                          ),
                        ),
                      ),

                      // Lottie.asset(
                      //   "assets/animations/signup.json",
                      //   height: 32.h,
                      // ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: DelayedDisplay(
                      slidingBeginOffset: Offset(0, 0),
                      delay: Duration(milliseconds:300),
                      child: HeadingText(
                          text: 'Setup Your Profile', textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                      child: DelayedDisplay(
                        slidingBeginOffset: Offset(0, 0),
                        delay: Duration(milliseconds:400),
                        child: SubHeadingText(
                            text: 'Create your account to get started'),
                      )),
                  SizedBox(height: 10,),
                  ProfilePicker(isFromSignUp: true,),
                  const SizedBox(
                    height: 30,
                  ),
                  const DelayedDisplay(
                      slidingBeginOffset: Offset(0, 0),
                      delay: Duration(milliseconds:500),
                      child: SubHeadingText(text: 'Username')),
                  const SizedBox(
                    height: 10,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(0, 0),
                    delay: const Duration(milliseconds:600),
                    child: CustomTextField.authInputFields(
                        validator: (value) => CustomValidator.isEmptyUserName(value),
                        textEditingController: userNameController,
                        hint: "Username",
                        prefixIcon: Image.asset(
                          'assets/icons/username.png',
                          height: 2,
                          color: Colors.white.withOpacity(0.6),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const DelayedDisplay(
                      slidingBeginOffset: Offset(0, 0),
                      delay: Duration(milliseconds:700),
                      child: SubHeadingText(text: 'E-mail')),
                  const SizedBox(
                    height: 10,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(0, 0),
                    delay: const Duration(milliseconds:800),
                    child: CustomTextField.authInputFields(
                        validator: (value) => CustomValidator.email(value),
                        textEditingController: emailController,
                        hint: "Email",
                        prefixIcon: Image.asset(
                          'assets/icons/email.png',
                          color: Get.isDarkMode
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const DelayedDisplay(
                      slidingBeginOffset: Offset(0, 0),
                      delay: Duration(milliseconds:900),
                      child: SubHeadingText(text: 'Password')),
                  const SizedBox(
                    height: 10,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(0, 0),
                    delay: const Duration(milliseconds:1000),
                    child: CustomTextField.authInputFields(
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
                                  ? Colors.white.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.6),
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
                  SizedBox(
                    height: 20,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(-10, 0),
                    delay: const Duration(seconds:1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        socialLoginWidget('assets/icons/Google.png'),
                        GestureDetector(
                          onTap: () {
                            if(_key.currentState!.validate()){
                              if(_authController.imagePathForSignUp.isEmpty){
                                CustomDialog.showErrorDialog(description: 'Please select image');
                              }else{
                                _authController.signUp(userNameController.text.toString(), emailController.text, passwordController.text.toString());

                              }
                              print("object");
                            }

                          },
                          child: Container(
                            width: 196,
                            height: 61,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFFA0D88D), Color(0xFF70B25D)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: subHeadingStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account?  ',
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white.withOpacity(0.699999988079071)
                                  : Colors.white.withOpacity(0.699999988079071),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const Login());
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // DelayedDisplay(
                  //   slidingBeginOffset: const Offset(0, 0),
                  //   delay: const Duration(milliseconds:1200),
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text.rich(
                  //       TextSpan(
                  //         children: [
                  //
                  //           TextSpan(
                  //             text: 'Already have an account?  ',
                  //             style: TextStyle(
                  //               color: AppColors.unSelectedColor,
                  //               fontSize: 13,
                  //               fontFamily: 'Poppins',
                  //               fontWeight: FontWeight.w600,
                  //               decoration: TextDecoration.underline,
                  //             ),
                  //           ),
                  //           TextSpan(
                  //             text: 'Sign In',
                  //             style: TextStyle(
                  //               color: AppColors.secondaryColor,
                  //               fontSize: 13,
                  //               fontFamily: 'Poppins',
                  //               fontWeight: FontWeight.w600,
                  //               decoration: TextDecoration.underline,
                  //             ),
                  //             recognizer: TapGestureRecognizer()
                  //               ..onTap = () {
                  //                 Get.to(() => const Login());
                  //               },
                  //           ),
                  //
                  //         ],
                  //       ),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget socialLoginWidget(String image) {
    return Container(
      width: 45,
      height: 45,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.20000000298023224)
                : Colors.black.withOpacity(0.20000000298023224),
          ),
          borderRadius: BorderRadius.circular(52),
        ),
      ),
      child: Image.asset(
        image,
      ),
    );
  }
}
