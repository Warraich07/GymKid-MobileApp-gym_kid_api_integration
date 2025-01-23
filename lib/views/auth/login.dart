import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/controllers/general_controller.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/res/dimens.dart';
import 'package:gym_kid/res/styles.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/forgot_passoword/forgot_password.dart';
import 'package:gym_kid/views/auth/signup/signup.dart';
import 'package:gym_kid/views/homescreen/home_screen.dart';
import 'package:gym_kid/views/navbar/bottom_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../components/page_navigation.dart';
import '../../constants/custom_validators.dart';
import '../../controllers/auth_controller.dart';
import 'components/backround_video.dart';
import 'components/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final AuthController _authController=Get.find();
  bool passwordVisible = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  GeneralController generalController=Get.find();


  // Widget socialLoginWidget(String image) {
  //   return Container(
  //     width: 45,
  //     height: 45,
  //     decoration: ShapeDecoration(
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(
  //           width: 1,
  //           color: Colors.white.withOpacity(0.20000000298023224),
  //         ),
  //         borderRadius: BorderRadius.circular(52),
  //       ),
  //     ),
  //     child: Image.asset(
  //       image,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: PAD_SYM_H20,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Spacer(flex: 1,),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
      
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Lottie.asset(
                          "assets/animations/signin.json",
                          height: 20.h,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const HeadingText(
                          text: 'Welcome Back', textAlign: TextAlign.start),
                      const SizedBox(
                        height: 10,
                      ),
                      const SubHeadingText(text: 'Sign In to your account'),
                      const SizedBox(
                        height: 40,
                      ),
                      const SubHeadingText(text: 'E-mail'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
      
                      CustomTextField.authInputFields(
                          validator: (value) => CustomValidator.email(value),
                          textEditingController: emailController,
                          hint: "Email",
                          prefixIcon: Image.asset(
                            'assets/icons/email.png',
                            color: Get.isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                          )),
                      const SizedBox(
                        height: 20,
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
      
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const ForgotPassword());
                            },
                            child: Text('Forgot Password?',
                                textAlign: TextAlign.center,
                                style:
                                smallTextStyle.copyWith(color: const Color(0xffE0AD3A))),
                          )),
                    ],
                  ),
                  // Spacer(flex: 1,),
      
                  Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      DelayedDisplay(
                        slidingBeginOffset: const Offset(-10, 0),
                        delay: const Duration(milliseconds:100),
                        child: CustomButton.commonButton(
                            buttonText: 'Sign In',
                            onTap: () {
                              if(_key.currentState!.validate()){
                                generalController.onBottomBarTapped(0);
                                _authController.loginUser(emailController.text.toString(), passwordController.text.toString());
                                print("ok");
                              }
                              //
                            }),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account?  ',
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
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const Signup());
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
      
                  // const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
