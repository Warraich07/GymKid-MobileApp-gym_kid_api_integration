import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/common_widget.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/forgot_passoword/otp_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../constants/custom_validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../res/dimens.dart';
import '../../../res/styles.dart';
import '../components/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController=TextEditingController();
  final AuthController _authController=Get.find();
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
                const HeadingText(text: 'Forgot Password?'),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Enter the email provided upon registration we will send you otp for password recovery.",
                  textAlign: TextAlign.start,
                  style: subHeadingStyle.copyWith(
                      color: Get.isDarkMode
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      height: 1.4
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const SubHeadingText(text: 'E-mail'),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _key,
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
                SizedBox(
                  height: 15.h,
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: CustomButton.commonButton(
                      onTap: () {
                        if(_key.currentState!.validate()){
                        _authController.sendOtpCode(emailController.text.toString());
                        }
                        // Get.to(() => OtpVerification());
                      },
                      buttonText: 'Send Code'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
