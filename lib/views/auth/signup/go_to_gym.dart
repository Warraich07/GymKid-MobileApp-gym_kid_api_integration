import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/views/auth/components/backround_video.dart';
import 'package:gym_kid/views/auth/components/common_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../components/common_widget.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helper/custom_dialogbox.dart';
import '../../../helper/shared_preference.dart';
import '../../../res/colors.dart';
import '../../../res/dimens.dart';
import '../components/auth_text.dart';
import 'age.dart';
import 'mode_prediction.dart';

class GoToGym extends StatefulWidget {
  const GoToGym({Key? key}) : super(key: key);

  @override
  State<GoToGym> createState() => _GoToGymState();
}

class _GoToGymState extends State<GoToGym> {

  int isSelected = 0;
  List<String> question = ['Nope!', 'Yes, I go'];
  final AuthController _authController=Get.find();
  final Set<int> selectedIndices = Set<int>();
  List<String> selectedGymStatusForCache=[];
  String retrievedGymStatusFromCache='';
  final AuthPreference _authPreference = AuthPreference.instance;


  void retrieveGymStatus() async {
    // Retrieve goals from cache
    retrievedGymStatusFromCache = await _authPreference.getGymStatus();
    print('Retrieved from cache: $retrievedGymStatusFromCache');
    for (int i = 0; i < question.length; i++) {

        if (question[i] == retrievedGymStatusFromCache) {
          print('Match found: ${question[i]}');
          selectedIndices.add(i);
          selectedGymStatusForCache.add(question[i]);
          setState(() {}); // Refresh the UI to reflect changes
        }

    }
    List<String> selectedStatuses = selectedIndices
        .map((index) => question[index])
        .toList();
    String selectedGoalsString = selectedStatuses.join(', ');
    print(selectedGoalsString+"asd");
    _authController.updateGymGoingStatus(selectedGoalsString);
  }
  String storedUserId='';
  void getUserId()async{
    storedUserId=await _authPreference.getUserIdInCache();
    setState(() {

    });
    // if(storedUserId==_authController.userID.value.toString()){
      retrieveGymStatus();
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
                  height: 60,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(onPressed: (){

                      Get.back();
                    }, icon: Icon(Icons.arrow_back,color: Colors.white,))),
                Center(
                  child: Lottie.asset(
                    "assets/animations/go_to_gym.json",
                    height: 20.h,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: HeadingText(
                      text: 'Do you go to gym?', textAlign: TextAlign.center),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: question.length,
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
                                      selectedGymStatusForCache.remove(question[index]);
                                    });
                                    print("shajd");
                                  } else {
                                    // selectedIndices.clear();
                                    selectedIndices.add(index);
                                    setState(() {
                                      selectedGymStatusForCache.add(question[index]);
                                    });
                                  }
                                  final isGoesToGym = selectedIndices
                                      .map((i) => question[i])
                                      .toList();
                                  final isGoesToGymString = isGoesToGym.join(', ');
                                  _authPreference.setGymStatus(isGoesToGymString);
                                  print(isGoesToGymString);
                                  _authController.updateGymGoingStatus(isGoesToGymString);

                                  // isSelected = index;
                                  // _authController.updateGymGoingStatus(question[index]);
                                  // print(_authController.isGoesToGym.value);
                                });
                              },
                              child: CommonContainer(
                                  selected: isSelected,
                                  text: question[index])),
                        );
                      }),
                ),
                DelayedDisplay(
                  slidingBeginOffset: const Offset(-10, 0),
                  delay: const Duration(milliseconds:100),
                  child: CustomButton.commonButton(
                      onTap: () {
                        if(_authController.isGoesToGym.isEmpty){
                          CustomDialog.showErrorDialog(description: "Please select one option");
                        }else{
                          // _authPreference.setGymStatus(selectedGymStatusForCache);
                          Get.to(() => const SelectAge(), transition: Transition.rightToLeftWithFade);
                        }
                      },
                      buttonText: 'Next'),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
