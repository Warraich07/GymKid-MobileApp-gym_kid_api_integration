
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_kid/components/custom_button.dart';
import 'package:gym_kid/components/custom_textfield.dart';
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
import 'go_to_gym.dart';
import 'mode_prediction.dart';

class ChooseGoal extends StatefulWidget {
  const ChooseGoal({Key? key}) : super(key: key);

  @override
  State<ChooseGoal> createState() => _ChooseGoalState();
}


class _ChooseGoalState extends State<ChooseGoal> {
  int isSelected = 0;
  String finalSelectedGoals='';
  List<String> goals = [
    'Overcome Depression',
    'Feel less anxious',
    'Gain mood insight',
    'Learn to practice Self-care'
  ];
  String finalSelectedReason='';
  List<String> selectedGoalsForCache=[];
  List<String> retrievedGoalsFromCache=[];
  final AuthPreference _authPreference = AuthPreference.instance;
  // List<String> selectedGoals = [];
  final AuthController _authController=Get.find();
  final Set<int> selectedIndices = Set<int>();

  void retrieveGoals() async {
    // Retrieve goals from cache
    retrievedGoalsFromCache = await _authPreference.getGoals();
    print('Retrieved from cache: $retrievedGoalsFromCache');
    for (int i = 0; i < goals.length; i++) {
      for (int j = 0; j < retrievedGoalsFromCache.length; j++) {
        if (goals[i] == retrievedGoalsFromCache[j]) {
          print('Match found: ${goals[i]}');
          selectedIndices.add(i);
          selectedGoalsForCache.add(goals[i]);
          setState(() {}); // Refresh the UI to reflect changes
        }
      }
    }
    List<String> selectedGoals = selectedIndices
        .map((index) => goals[index])
        .toList();
    String selectedGoalsString = selectedGoals.join(', ');
    _authController.updateGoal(selectedGoalsString);
    print(_authController.selectedGoal.toString()+"sel goal");

  }
  String storedUserId='';
void getUserId()async{
   storedUserId=await _authPreference.getUserIdInCache();
   setState(() {

   });
   print(storedUserId+"  +  "+_authController.userID.value.toString());
   // if(storedUserId==_authController.userID.value.toString()) {
     retrieveGoals();
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
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
      body: BackgroundImage(
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
                    height: 40,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CommonWidget.backbutton()),
                  // Center(
                  //   child: Lottie.asset(
                  //     "assets/animations/goal.json",
                  //     height: 32.h,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/goal.png",
                        height: 15.h,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: HeadingText(
                        text: 'Choose your goals', textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                        '(Choose at least two)', textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 16),),
                  ),

                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                        itemCount: goals.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndices.contains(index);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedIndices.remove(index);
                                      setState(() {
                                        selectedGoalsForCache.remove(goals[index]);

                                      });
                                    } else {
                                      selectedIndices.add(index);
                                      setState(() {
                                        selectedGoalsForCache.add(goals[index]);

                                      });
                                    }
                                    final selectedGoals = selectedIndices
                                        .map((i) => goals[i])
                                        .toList();
                                    final selectedGoalsString = selectedGoals.join(', ');
                                    _authController.updateGoal(selectedGoalsString);
                                  });
                                },
                                child: CommonContainer(
                                    selected: isSelected,
                                    text: goals[index])),
                          );
                        }),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //
                  //     border: Border.all(color: Get.isDarkMode ? Colors.white : Colors.black,)
                  //   ),
                  //   child: Center(
                  //     child: ConstrainedBox(
                  //       constraints: BoxConstraints(minHeight: 180, maxHeight: 180),
                  //       child: TextFormField(
                  //         maxLength: 100,
                  //         cursorColor: Get.isDarkMode ? Colors.white : Colors.black,
                  //         style: TextStyle(
                  //             fontSize: 15, overflow: TextOverflow.ellipsis),
                  //         maxLines: 10,
                  //         decoration: InputDecoration(
                  //           contentPadding: const EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           border: InputBorder.none,
                  //           focusedBorder: InputBorder.none,
                  //           enabledBorder: InputBorder.none,
                  //           hintText: "Describe your Jersey...",
                  //           hintStyle: TextStyle(
                  //               color: Get.isDarkMode? Colors.white54: Colors.white54, fontSize: 15),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 30,),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(-10, 0),
                    delay: const Duration(milliseconds:100),
                    child: CustomButton.commonButton(
                        onTap: () {
                          if(_authController.selectedGoal.isEmpty || selectedGoalsForCache.length<2){
                            print(_authController.selectedGoal.toString()+"sdha");
                            CustomDialog.showErrorDialog(description: "Please select at least two goals");
                          }else{

                            _authPreference.setGoals(selectedGoalsForCache);
                            Get.to(() => const GoToGym(), transition: Transition.rightToLeftWithFade);
                          }
                          print(_authController.selectedGoal.value);
                        },
                        buttonText: 'Next'),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
