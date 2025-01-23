import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/common_widget.dart';
import 'package:gym_kid/res/colors.dart';
import 'package:gym_kid/views/auth/components/auth_text.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helper/custom_dialogbox.dart';
import '../../../res/dimens.dart';
import '../../../res/styles.dart';
import '../components/custom_text_field.dart';
import 'change_password.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final AuthController _authController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        // backgroundColor:
        //     Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
        child: SingleChildScrollView(
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
                const HeadingText(text: 'OTP Verification'),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Enter the verification OTP we just sent you on your email address.",
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
                const OtpField(
                ),
                SizedBox(
                  height: 13.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Didn\'t you receive any code? ',
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.white : Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'RESEND',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            _authController.sendOtpCode(_authController.verifiedEmail.value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: CustomButton.commonButton(
                      onTap: () {

                            _authController.verifyOtp();


      
                      },
                      buttonText: 'Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
