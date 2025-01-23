// import 'package:delayed_display/delayed_display.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gym_kid/components/custom_button.dart';
// import 'package:gym_kid/views/homescreen/components/gauge_meter.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../components/meter.dart';
// import '../../../res/colors.dart';
// import '../../../res/dimens.dart';
// import '../components/auth_text.dart';
// import 'age.dart';
//
// class MoodPrediction extends StatefulWidget {
//   const MoodPrediction({Key? key}) : super(key: key);
//
//   @override
//   State<MoodPrediction> createState() => _MoodPredictionState();
// }
//
// class _MoodPredictionState extends State<MoodPrediction> {
//   List<String> selectedGoals = [];
//
//   double initialValue = 10.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           Get.isDarkMode ? AppColors.backgroundColor : Colors.white,
//       body: Padding(
//         padding: PAD_SYM_H20,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: DelayedDisplay(
//             slidingBeginOffset: const Offset(0, 0),
//             delay: const Duration(milliseconds:200),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 SizedBox(
//                   height: 32.h,
//                   width: Get.width,
//                   child: Center(
//                     child: GaugeMeterWidget(
//                       topPosition: 23.h,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Center(
//                   child: HeadingText(
//                       text: 'Mood Prediction', textAlign: TextAlign.center),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Center(
//                   child: SubHeadingText(
//                     text: 'Allow gym_kid to access your physical activity:',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: Get.width,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset(
//                         'assets/icons/mood.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Mood Prediction Score',
//                               style: TextStyle(
//                                   color:
//                                       Get.isDarkMode ? Colors.white : Colors.black,
//                                   fontSize: 20,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w500,
//                                   height: 1),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             const Text(
//                               "gym_kid app will predict your physical activity data",
//                               style: TextStyle(
//                                 color: Color(0xFFA3A3A3),
//                                 fontSize: 15,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   width: Get.width,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset(
//                         'assets/icons/thumb.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'The Recommendation',
//                               style: TextStyle(
//                                   color:
//                                       Get.isDarkMode ? Colors.white : Colors.black,
//                                   fontSize: 20,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w500,
//                                   height: 1),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             const Text(
//                               "Knowing your mood patterns helps the gym_kid app to make action based suggestions for you to improve",
//                               style: TextStyle(
//                                 color: Color(0xFFA3A3A3),
//                                 fontSize: 15,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 CustomButton.commonButton(
//                     onTap: () {
//                       Get.to(() => const SelectAge(), transition: Transition.rightToLeftWithFade);
//                     },
//                     buttonText: 'Next'),
//                 TextButton(
//                     onPressed: () {
//                       Get.to(() => const SelectAge(), transition: Transition.rightToLeftWithFade);
//                     },
//                     child: const Text(
//                       'Skip for now',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xFFA3A3A3),
//                         fontSize: 15,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w400,
//                         height: 0.09,
//                       ),
//                     )),
//                 const SizedBox(height: 30,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
