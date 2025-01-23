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
import 'choose_goal.dart';

class Reason extends StatefulWidget {
  const Reason({Key? key}) : super(key: key);

  @override
  State<Reason> createState() => _ReasonState();
}

class _ReasonState extends State<Reason> {
  final List<String> reason = [
    "Competition Prep",
    "Tackle Blocks",
    "Injury & Recovery",
    "Track Progress"
  ];
  final Set<int> selectedIndices = Set<int>();
  final AuthController _authController = Get.find();
  List<String> selectedReasonsForCache=[];
  List<String> retrievedReasonsFromCache=[];

  final AuthPreference _authPreference = AuthPreference.instance;
  void retrieveReasons() async {
    // Retrieve goals from cache
    retrievedReasonsFromCache = await _authPreference.getReasons();
    print('Retrieved from cache: $retrievedReasonsFromCache');
    for (int i = 0; i < reason.length; i++) {
      for (int j = 0; j < retrievedReasonsFromCache.length; j++) {
        if (reason[i] == retrievedReasonsFromCache[j]) {
          print('Match found: ${reason[i]}');
          selectedIndices.add(i);
          selectedReasonsForCache.add(reason[i]);
          setState(() {}); // Refresh the UI to reflect changes
        }
      }
    }

    List<String> selectedReasons = selectedIndices
        .map((index) => reason[index])
        .toList();
    String selectedReasonsString = selectedReasons.join(', ');
    _authController.updateSelectedReason(selectedReasonsString);

  }
  String storedUserId='';
  void getUserId()async{

    storedUserId=await _authPreference.getUserIdInCache();
    setState(() {

    });
    // if(storedUserId==_authController.userID.value.toString()){
      retrieveReasons();
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
              delay: const Duration(milliseconds: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 40),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CommonWidget.backbutton()),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/i_am_here.png",
                        height: 15.h,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Center(
                    child: HeadingText(
                      text: 'I am here to:',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      itemCount: reason.length,
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
                                    selectedReasonsForCache.remove(reason[index]);

                                  });
                                } else {
                                  selectedIndices.add(index);
                                  setState(() {
                                    selectedReasonsForCache.add(reason[index]);

                                  });
                                }
                                final selectedReasons = selectedIndices
                                    .map((i) => reason[i])
                                    .toList();
                                final selectedReasonsString = selectedReasons.join(', ');
                                _authController.updateSelectedReason(selectedReasonsString);
                              });
                            },
                            child: CommonContainer(
                              selected: isSelected,
                              text: reason[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: const Offset(-10, 0),
                    delay: const Duration(milliseconds:100),
                    child: CustomButton.commonButton(
                      onTap: () {
                        if(_authController.selectedReason.isEmpty){
                          CustomDialog.showErrorDialog(description: "Please select at least one reason");
                        }else{
                          Get.to(
                                () => const ChooseGoal(),
                            transition: Transition.rightToLeftWithFade,
                          );
                          _authPreference.setReasons(selectedReasonsForCache);
                          print(_authController.selectedReason.value);
                        }

                      },
                      buttonText: 'Next',
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:delayed_display/delayed_display.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gym_kid/components/custom_button.dart';
// import 'package:gym_kid/views/auth/components/backround_video.dart';
// import 'package:gym_kid/views/auth/components/common_widget.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../controllers/auth_controller.dart';
// import '../../../res/colors.dart';
// import '../../../res/dimens.dart';
// import '../components/auth_text.dart';
// import 'choose_goal.dart';
//
// class Reason extends StatefulWidget {
//   const Reason({Key? key}) : super(key: key);
//
//   @override
//   State<Reason> createState() => _ReasonState();
// }
//
// class _ReasonState extends State<Reason> {
//   List<String> reason = [
//     "Competition Prep",
//     "Tackle Blocks",
//     "Injury & Recovery",
//     "Track Progress"
//   ];
//   List<String> selectedReasons = [];
//   int isSelected = 0;
//   final AuthController _authController=Get.find();
//   // String selectedReason="Competition Prep";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
//       body: BackgroundImage(
//         child: Padding(
//           padding: PAD_SYM_H20,
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: DelayedDisplay(
//               slidingBeginOffset: const Offset(0, 0),
//               delay: const Duration(milliseconds:200),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   // Center(
//                   //   child: Lottie.asset(
//                   //    "assets/animations/i_am_here.json",
//                   //     height: 32.h,
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Center(
//                       child: Image.asset(
//                         "assets/images/i_am_here.png",
//                         height: 35.h,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   const Center(
//                     child: HeadingText(
//                         text: 'I am here to:', textAlign: TextAlign.center),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     height: 40.h,
//                     child: ListView.builder(
//                         itemCount: reason.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 10.0),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     // print(selectedReason);
//                                     isSelected = index;
//                                     // // _authController.updateSelectedReason(selectedReasons);
//                                     // selectedReasons.add(reason[index]);
//                                     // print(selectedReasons);
//                                     //
//                                     // // _authController.updateSelectedReason(reason[index]);
//                                     // // print(_authController.selectedReason.value);
//                                     // // selectedReason=;
//                                     // // print(selectedReason);
//                                   });
//                                 },
//                                 child: CommonContainer(
//                                     selected: isSelected == index,
//                                     text: reason[index])),
//                           );
//                         }),
//                   ),
//                   CustomButton.commonButton(
//                       onTap: () {
//                         print("object");
//                         Get.to(() => const ChooseGoal(), transition: Transition.rightToLeftWithFade);
//                       },
//                       buttonText: 'Next'),
//                   SizedBox(height: 30,),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
