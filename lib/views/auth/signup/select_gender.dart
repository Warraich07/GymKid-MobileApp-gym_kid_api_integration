import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/views/auth/components/common_widget.dart';
import 'package:gym_kid/views/auth/login.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../components/common_widget.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helper/custom_dialogbox.dart';
import '../../../helper/shared_preference.dart';
import '../../../res/colors.dart';
import '../../../res/dimens.dart';
import '../components/auth_text.dart';
import '../components/backround_video.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key}) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int isSelected = 0;
  List<String> genderList = [
    'Male',
    'Female',
    'Non-Binary',
    'Not-Disclosing',
  ];
  final AuthController _authController=Get.find();
  final Set<int> selectedIndices = Set<int>();
  List<String> selectedGenderForCache=[];
  String retrievedGenderFromCache='';
  final AuthPreference _authPreference = AuthPreference.instance;

  void retrieveGender() async {
    // Retrieve goals from cache
    retrievedGenderFromCache = await _authPreference.getGymStatus();
    print('Retrieved from cache: $retrievedGenderFromCache');
    for (int i = 0; i < genderList.length; i++) {

      if (genderList[i] == retrievedGenderFromCache) {
        print('Match found: ${genderList[i]}');
        selectedIndices.add(i);
        selectedGenderForCache.add(genderList[i]);
        setState(() {}); // Refresh the UI to reflect changes
      }

    }
    List<String> selectedStatuses = selectedIndices
        .map((index) => genderList[index])
        .toList();
    String selectedGoalsString = selectedStatuses.join(', ');
    print(selectedGoalsString+"asd");
    _authController.updateSelectedGender(selectedGoalsString);
  }

  String storedUserId='';
  void getUserId()async{
    storedUserId=await _authPreference.getUserIdInCache();
    setState(() {

    });
    // if(storedUserId==_authController.userID.value.toString()) {
      retrieveGender();
    // }

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

      child: Padding(
        padding: PAD_SYM_H16,
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: CommonWidget.backbutton()),
                // Center(
                //   child: Lottie.asset(
                //     "assets/animations/gender.json",
                //     height: 36.h,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Image.asset(
                      "assets/images/gender.png",
                      height: 15.h,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                const Center(
                  child: HeadingText(
                      text: 'Specify your gender', textAlign: TextAlign.center),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: SubHeadingText(
                    text:
                        'This will help Gym Kid to give an accurate mood score based on people similar to you',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: genderList.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndices.contains(index);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                selectedIndices.clear();
                                setState(() {
                                  if (isSelected) {
                                    selectedIndices.remove(index);
                                    setState(() {
                                      selectedGenderForCache.remove(genderList[index]);
                                    });
                                    print("shajd");
                                  } else {
                                    // selectedIndices.clear();
                                    selectedIndices.add(index);
                                    setState(() {
                                      selectedGenderForCache.add(genderList[index]);
                                    });
                                  }
                                  final isGoesToGym = selectedIndices
                                      .map((i) => genderList[i])
                                      .toList();
                                  final selectedGender = isGoesToGym.join(', ');
                                  _authPreference.setGender(selectedGender);
                                  print(selectedGender);
                                  _authController.updateSelectedGender(selectedGender);

                                  // isSelected = index;
                                  // _authController.updateGymGoingStatus(question[index]);
                                  // print(_authController.isGoesToGym.value);
                                });
                              },
                              child: CommonContainer(
                                  selected: isSelected,
                                  text: genderList[index])),
                        );
                      }),
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: CustomButton.commonButton(
                      onTap: () {
                        if(_authController.selectedGender.isEmpty){
                          CustomDialog.showErrorDialog(description: "Please select gender");
                        }else{
                          _authController.completeProfile();
                          // _authPreference.setGymStatus(selectedGymStatusForCache);
                          // Get.to(() => const SelectAge(), transition: Transition.rightToLeftWithFade);
                        }
                        print(_authController.selectedGoal.value);

                        // Get.to(() => const Login(), transition: Transition.zoom);
                      },
                      buttonText: 'Get Started'),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),);

  }
}
