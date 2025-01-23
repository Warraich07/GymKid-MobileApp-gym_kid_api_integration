import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/signup/select_gender.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

import '../../../components/common_widget.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helper/shared_preference.dart';
import '../../../res/colors.dart';
import '../../../res/dimens.dart';
import '../components/auth_text.dart';

class SelectAge extends StatefulWidget {
  const SelectAge({Key? key}) : super(key: key);

  @override
  State<SelectAge> createState() => _SelectAgeState();
}

class _SelectAgeState extends State<SelectAge> {

  // int _currentValue = 10;
  final AuthController _authController=Get.find();

  final Set<int> selectedIndices = Set<int>();
  int selectedAgeForCache=0;
  int retrievedAgeFromCache=0;
  final AuthPreference _authPreference = AuthPreference.instance;

int age=0;
  void retrieveAge() async {
    age=await _authPreference.getAge();
    if(age!=0){
      _authController.updateSelectedAge(age);
    }

     print(age.toString());
  }
  String storedUserId='';
  void getUserId()async{
    storedUserId=await _authPreference.getUserIdInCache();
    setState(() {

    });
    retrieveAge();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserId();

  }
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child:  Padding(
          padding: PAD_SYM_H20,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: DelayedDisplay(
              slidingBeginOffset: const Offset(0, 0),
              delay: const Duration(milliseconds:200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // Center(
                  //   child: Lottie.asset(
                  //     "assets/animations/age.json",
                  //     height: 38.h,
                  //   ),
                  // ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CommonWidget.backbutton()),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/age.png",
                        height: 20.h,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: HeadingText(
                        text: 'How old are you?', textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: SubHeadingText(
                      text:
                          "Where you are in your journey can help Gym Kid create the best recommendations for you",
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    ()=> Center(
                      child: NumberPicker(
                        zeroPad: true,
                        itemHeight: 50,
                        haptics: true,
                        value:_authController.selectedAge.value,
                        selectedTextStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white,
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        textStyle: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        minValue: 12,
                        maxValue: 80,
                        onChanged: (value) {
                          _authPreference.setAge(value);
                          _authController.updateSelectedAge(value);
                          print(_authController.selectedAge);
                          // setState(() => _currentValue = value);
                          print(value.toString());
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(-10, 0),
                    delay: const Duration(milliseconds:100),
                    child: CustomButton.commonButton(
                        onTap: () {
                          Get.to(() => const SelectGender(), transition: Transition.rightToLeftWithFade);
                        },
                        buttonText: 'Next'),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
